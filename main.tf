resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "soc-project-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true //

  tags = {
    Name = "soc-project-public-subnet"
  }
}


# 1. Cria o Internet Gateway para dar acesso a internet para a VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "soc-project-igw"
  }
}

# 2. Cria uma nova Tabela de Rotas para a sub-rede publica
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    # Para todo o trafego destinado a internet (0.0.0.0/0),
    # envie atraves do nosso Internet Gateway.
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "soc-project-public-rt"
  }
}

# 3. Associa a nova Tabela de Rotas com a nossa sub-rede publica
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# 4. Cria o Grupo de Segurança para o nosso firewall
resource "aws_security_group" "pfsense_sg" {
  name        = "pfsense-sg"
  description = "Permite acesso SSH e web ao firewall PFSense"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH para administracao"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # AVISO: Apenas para estudo. Em produção, seria seu IP.
  }

  ingress {
    description = "HTTPS para interface web do firewall"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "Permite todo o trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "soc-project-pfsense-sg"
  }
}


# 5. Cria a Instancia EC2 para ser o firewall
resource "aws_instance" "pfsense_ec2" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t3.small"  # <--- VOLTAMOS PARA A SMALL
  
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.pfsense_sg.id]
  key_name               = "soc-keypair"

  # Mantemos o disco grande para caber o Docker e o Swap
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "soc-project-firewall-server"
  }
}