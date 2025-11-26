# 🛡️ Projeto: SOC na Nuvem com IaC (Infrastructure as Code)

![Status](https://img.shields.io/badge/status-ativo-brightgreen)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-%232496ED.svg?style=for-the-badge&logo=docker&logoColor=white)
![Wazuh](https://img.shields.io/badge/Wazuh-SIEM-blue?style=for-the-badge)

Este repositório documenta a engenharia e construção de um **Centro de Operações de Segurança (SOC)** funcional na AWS. O ambiente é provisionado 100% via código (Terraform) e foca na detecção de ameaças em tempo real, superando restrições de hardware e custos de nuvem.

---

### 📋 Tabela de Conteúdos
1. [Visão Geral e Objetivos](#1-visão-geral-e-objetivos)
2. [Arquitetura e Tech Stack](#2-arquitetura-e-tech-stack)
3. [Desafios de Engenharia (Troubleshooting)](#3-desafios-de-engenharia-troubleshooting)
4. [Roadmap do Projeto](#4-roadmap-do-projeto)
5. [Resultados e Evidências (PoC)](#5-resultados-e-evidências-poc)
6. [Como Reproduzir o Lab](#6-como-reproduzir-o-lab)
7. [Contato](#7-contato)

---

### **1. Visão Geral e Objetivos**

A falta de visibilidade é o maior risco na nuvem. Este projeto resolve esse problema criando um ambiente monitorado onde cada tentativa de acesso é registrada e analisada.

**Objetivos Técnicos:**
* Provisionar infraestrutura segura na AWS usando Terraform.
* Implementar um SIEM (Wazuh) para análise de logs e detecção de intrusão.
* Demonstrar ciclo de vida de DevSecOps (Build -> Attack -> Detect -> Destroy).

---

### **2. Arquitetura e Tech Stack**

O projeto utiliza uma arquitetura "All-in-One" otimizada para baixo custo, rodando sobre containers.

* **Cloud Provider:** AWS (VPC, Subnets Públicas, EC2, Security Groups, Internet Gateway).
* **Infrastructure as Code:** Terraform (HCL).
* **SIEM / EDR:** Wazuh (Manager, Indexer, Dashboard) rodando em **Docker**.
* **Segurança de Rede:** Controle via Security Groups (Portas 22, 443, 1514, 1515).
* **Sistema Operacional:** Ubuntu Server 22.04 LTS.

---

### **3. Desafios de Engenharia (Troubleshooting)**

Durante o desenvolvimento, enfrentei limitações reais de hardware no *Free Tier* da AWS. Abaixo, as soluções de engenharia aplicadas:

| Desafio | Solução Aplicada |
| :--- | :--- |
| **Falta de Memória RAM** | Implementação de **4GB de Swap File** via script de *user data*, permitindo rodar o stack Wazuh (Java/Elastic) em uma instância `t3.small`. |
| **Instabilidade de Instalação** | Migração da instalação via script nativo para **Docker Containers**, garantindo isolamento, idempotência e maior velocidade de deploy. |
| **Espaço em Disco** | Provisionamento via Terraform de um volume **EBS gp3 de 20GB**, superando o limite padrão de 8GB das instâncias básicas. |

---

### **4. Roadmap do Projeto**

- [x] **Capítulo 1: A Fundação**
  - Configuração do ambiente (Terraform, AWS CLI).
  - Provisionamento da rede base (VPC, Subnet).

- [x] **Capítulo 2: Construindo o Perímetro**
  - Internet Gateway e Tabelas de Rotas.
  - Provisionamento de instâncias EC2 com IP público automático.

- [x] **Capítulo 3: O Cérebro do SOC**
  - Deploy do Wazuh Manager via Docker em instância `t3.small`.
  - Configuração de Swap e otimização do Linux.

- [x] **Capítulo 4: A Vítima**
  - Provisionamento de uma instância `t3.micro` separada.
  - Instalação e registro do **Wazuh Agent**.

- [x] **Capítulo 5: O Teste de Fogo (Attack Simulation)**
  - Simulação de ataque de **Brute Force SSH**.
  - Validação dos alertas no Dashboard (Nível 5+).

- [ ] **Capítulo 6: Automação de Resposta (SOAR)**
  - Integração com **n8n**.
  - Automação de alertas via Discord/Slack.

---

### **5. Resultados e Evidências (PoC)**

O ambiente foi validado através de um ataque simulado contra a máquina vítima.

**Fluxo do Teste:**
1.  O atacante tentou login via SSH com usuário inexistente ("hacker").
2.  O Agente Wazuh detectou a falha de autenticação.
3.  O evento foi correlacionado pelo Manager.
4.  O Dashboard gerou um alerta de **Nível 5**.


### 🎥 Demonstração Prática
Aqui podemos ver o alerta sendo gerado em tempo real após o comando SSH:

![Demonstração do Wazuh](./demo-wazuh.gif)


---

### **6. Como Reproduzir o Lab**

Pré-requisitos: Terraform instalado e credenciais AWS configuradas.

### 1. **Clone o repositório:**
```bash
   git clone [URL_DO_SEU_REPO]
   cd aws-cloud-soc-terraform
   terraform init
   terraform apply -auto-approve

### Prepara Swap e Docker
 ```bash
 sudo apt update && sudo apt upgrade -y
 sudo fallocate -l 4G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile
 curl -fsSL [https://get.docker.com](https://get.docker.com) -o get-docker.sh && sudo sh get-docker.sh
 sudo usermod -aG docker ubuntu && sudo apt install docker-compose -y

### Sobe o Wazuh
 ```bash
 git clone [https://github.com/wazuh/wazuh-docker.git](https://github.com/wazuh/wazuh-docker.git) -b v4.7.5
 cd wazuh-docker/single-node
 sudo docker-compose -f generate-indexer-certs.yml run --rm generator
 sudo docker-compose up -d

### Limpeza (Destruir tudo para evitar custos):
 ```bash
 terraform destroy -auto-approve

### 7. **Contato**
Kaike Almeida - LinkedIn

Projeto desenvolvido com foco em aprendizado prático de DevSecOps e Cloud Security.