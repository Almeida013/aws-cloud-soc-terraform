# 🚀 Projeto: SOC na Nuvem com IaC (Infrastructure as Code)

![Status](https://img.shields.io/badge/status-em%20andamento-yellow)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)

Este repositório documenta a jornada de construção de um Centro de Operações de Segurança (SOC) funcional e de baixo custo na AWS, totalmente provisionado via Terraform. O objetivo é criar um sistema de defesa e detecção de ameaças do zero, demonstrando habilidades práticas em Cloud Security e DevSecOps.

---

### Tabela de Conteúdos
1. [Visão Geral do Projeto](#1-visão-geral-do-projeto)
2. [Stack Tecnológica](#2-stack-tecnológica)
3. [Roadmap do Projeto](#3-roadmap-do-projeto)
4. [Arquitetura da Solução](#4-arquitetura-da-solução)
5. [Como Executar](#5-como-executar)
6. [Contato](#6-contato)

---

### **1. Visão Geral do Projeto**

Em cibersegurança, visibilidade não é um luxo, é uma necessidade. Muitas empresas operam na nuvem sem um monitoramento claro sobre ameaças como tentativas de invasão, varreduras de vulnerabilidades ou atividades anômalas. Este projeto ataca essa dor de frente, construindo uma solução que centraliza logs, monitora a integridade de arquivos e gera alertas em tempo real.

### **2. Stack Tecnológica**

* **Cloud Provider:** AWS (VPC, EC2, IAM, Security Groups)
* **Infrastructure as Code:** Terraform
* **SIEM / EDR:** Wazuh
* **Firewall / Roteador:** PFSense
* **Versionamento:** Git & GitHub

### **3. Roadmap do Projeto**

Este projeto está sendo construído em fases. Abaixo está o progresso atual.

- [x] **Capítulo 1: A Fundação (CONCLUÍDO)**
  - [x] Configuração do ambiente local (Terraform, AWS CLI, Git).
  - [x] Criação da conta AWS e configuração de segurança (Budget, IAM).
  - [x] Provisionamento da rede base com Terraform (`aws_vpc`, `aws_subnet`).

- [ ] **Capítulo 2: Construindo o Perímetro de Segurança**
  - [ ] Provisionar o Internet Gateway (`aws_internet_gateway`).
  - [ ] Criar e associar a Tabela de Rotas (`aws_route_table`).
  - [ ] Provisionar a Instância EC2 para o PFSense (`aws_instance`).
  - [ ] Alocar e associar um IP Público Fixo (`aws_eip`).

- [ ] **Capítulo 3: O Cérebro do SOC (Instalação das Ferramentas)**
  - [ ] Provisionar a Instância EC2 para o Wazuh Manager.
  - [ ] Realizar o acesso via SSH às instâncias.
  - [ ] Instalar o servidor do Wazuh.

- [ ] **Capítulo 4: Ativando a Vigilância (Integração dos Agentes)**
  - [ ] Provisionar uma Instância EC2 "Vítima" na rede privada.
  - [ ] Instalar o agente do Wazuh na máquina vítima.
  - [ ] Registrar o agente e confirmar a comunicação no painel do Wazuh.

- [ ] **Capítulo 5: O Teste de Fogo (Simulação de Ataques)**
  - [ ] Simular ataques (Brute-force, Port Scan) contra a máquina vítima.
  - [ ] Capturar os alertas gerados no painel do Wazuh.

- [ ] **Capítulo 6: A Apresentação Final (Documentação e Limpeza)**
  - [ ] Finalizar este README com o diagrama final e os screenshots dos resultados.
  - [ ] Executar `terraform destroy` para remover todos os recursos da AWS.

### **4. Arquitetura da Solução**

A arquitetura será atualizada a cada capítulo concluído.

**Arquitetura Atual (Capítulo 1):**
![Arquitetura Capítulo 1](https://via.placeholder.com/800x450.png?text=Cap%C3%ADtulo+1:+Infraestrutura+de+Rede+Base+(VPC+%2B+Subnet))

### **5. Como Executar**

1.  Clone este repositório: `git clone [URL_DO_SEU_REPO]`
2.  Configure suas credenciais da AWS.
3.  Navegue para a pasta do projeto e execute `terraform init`.
4.  Revise o plano de execução com `terraform plan`.
5.  Aplique a infraestrutura com `terraform apply`.

### **6. Contato**

Kaike Almeida - [LinkedIn](https://www.linkedin.com/in/kaikealmeida)