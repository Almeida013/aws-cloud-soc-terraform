resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "soc-project-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "soc-project-public-subnet"
  }
}


# 1. Cria o Internet Gateway para dar acesso à internet para a VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "soc-project-igw"
  }
}

# 2. Cria uma nova Tabela de Rotas para a sub-rede pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    # Para todo o tráfego destinado à internet (0.0.0.0/0),
    # envie através do nosso Internet Gateway.
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "soc-project-public-rt"
  }
}

# 3. Associa a nova Tabela de Rotas com a nossa sub-rede pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}