<div align="center">

# 🛡️ SOC na Nuvem: Detecção e Resposta Automatizada (SOAR)
## AWS | Wazuh | n8n | Terraform

![Status Project](https://img.shields.io/badge/status-concluído-brightgreen?style=for-the-badge)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Wazuh](https://img.shields.io/badge/Wazuh-SIEM-blue?style=for-the-badge&logo=wazuh&logoColor=white)
![n8n](https://img.shields.io/badge/n8n-SOAR-ff6d5a?style=for-the-badge&logo=n8n&logoColor=white)

<p align="center">
  <b>Simulação de um Centro de Operações de Segurança (SOC) com Infraestrutura como Código (IaC).</b><br>
  Detecção de intrusão e resposta automática a incidentes (SOAR) em ambiente Cloud.
</p>

</div>

---

## 📋 Tabela de Conteúdos

1. [Arquitetura da Solução](#1-arquitetura-da-solução)
2. [Fluxo de Defesa](#2-fluxo-de-defesa-o-que-ele-faz)
3. [Desafios de Engenharia](#3-desafios-de-engenharia-troubleshooting)
4. [Roadmap Executado](#4-roadmap-executado)
5. [Resultados e Evidências](#5-resultados-e-evidências-poc)
6. [Como Reproduzir](#6-como-reproduzir)

---

## 1. Arquitetura da Solução

O ambiente foi desenhado para simular um cenário real de **Red Team vs Blue Team**, composto por:

* ☁️ **Infraestrutura AWS:** VPC Customizada, Subnets Públicas, Internet Gateway e Security Groups configurados via Terraform.
* 👁️ **Wazuh (SIEM):** Responsável pela coleta de logs, análise de integridade de arquivos (FIM) e detecção de intrusão. Rodando em Docker.
* 🐙 **n8n (Automação/SOAR):** Orquestrador de resposta. Recebe o alerta do Wazuh e executa ações diretas na API da AWS.
* 🎯 **Máquina Vítima:** Instância EC2 propositalmente vulnerável para testes de penetração.
* ⚔️ **Máquina Atacante:** Instância "Kali Linux/Red Team" para simular invasões externas.

---

## 2. Fluxo de Defesa (O Que Ele Faz?)

A automação segue um fluxo lógico de **Detecção -> Análise -> Resposta**:

1.  🔴 **Ataque:** Um atacante tenta realizar *Brute Force SSH* contra a infraestrutura.
2.  🔍 **Detecção:** O Agente Wazuh na máquina vítima identifica a anomalia nos logs de autenticação.
3.  🚨 **Alerta:** O Wazuh Manager gera um alerta de **Nível 10** e dispara um Webhook.
4.  ⚙️ **Orquestração:** O **n8n** captura o JSON do alerta e extrai o IP de origem do atacante via Regex.
5.  🛡️ **Resposta:** O n8n autentica na AWS e injeta uma regra na **Network ACL (NACL)** bloqueando todo tráfego vindo daquele IP.
6.  🔔 **Notificação:** Um relatório detalhado do incidente é enviado instantaneamente para o canal do **Discord** da equipe de segurança.

---

## 3. Desafios de Engenharia (Troubleshooting)

Durante o desenvolvimento, diversas limitações de ambiente Cloud e Hardware foram superadas:

| Desafio | Solução Aplicada |
| :--- | :--- |
| **Recursos Limitados (RAM)** | Implementação de **4GB de Swap** para rodar a stack Java/Elastic do Wazuh em instância `t3.small` (evitando falhas por OOM - Out of Memory). |
| **Instabilidade de Deploy** | Migração de scripts de instalação manuais para **Docker Containers**, garantindo isolamento, versionamento e idempotência da aplicação. |
| **Cotas da AWS** | Contorno de restrições de conta AWS (que bloqueava instâncias maiores) através da otimização de software e expansão dinâmica de disco EBS (20GB). |

---

## 4. Roadmap Executado

- [x] **Fase 1: Infraestrutura (IaC)** - Provisionamento de rede e servidores com Terraform.
- [x] **Fase 2: Monitoramento** - Deploy do Wazuh Manager e instalação dos Agentes.
- [x] **Fase 3: Detecção** - Criação de regras customizadas para identificar ataques SSH.
- [x] **Fase 4: Automação (SOAR)** - Integração completa: Wazuh ➡️ n8n ➡️ AWS VPC.
- [x] **Fase 5: Teste de Fogo** - Simulação real de ataque e validação do bloqueio automático.

---

## 5. Resultados e Evidências (PoC)

### 🎥 O Ataque e o Bloqueio
> *(Insira aqui seu GIF ou Link do vídeo mostrando o terminal do atacante travando)*

### **6. Como Reproduzir o Lab**

Siga este passo a passo para subir o ambiente completo em sua conta AWS.

#### **Pré-requisitos**
* AWS CLI instalado e configurado.
* Terraform instalado.
* Git instalado.

#### **Passo 1: Clonar e Provisionar (Terraform)**
Baixe o código e crie a infraestrutura na AWS.

```bash
git clone [https://github.com/Almeida013/aws-cloud-soc-terraform](https://github.com/Almeida013/aws-cloud-soc-terraform)
cd aws-cloud-soc-terraform

# Inicialize e aplique o plano
terraform init
terraform apply -auto-approve

Com certeza! Vou reescrever o seu README.md completo.

A seção "6. Como Reproduzir" foi totalmente detalhada para ser "à prova de erros". Ela explica como usar os arquivos que acabamos de criar (setup.sh e workflow.json) para que qualquer pessoa (ou você no futuro) consiga subir esse laboratório em minutos sem dor de cabeça.

Copie o código abaixo e substitua tudo no seu arquivo README.md.

Markdown

# 🛡️ SOC na Nuvem: Detecção e Resposta Automatizada (SOAR)

![Status](https://img.shields.io/badge/status-concluído-brightgreen)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Wazuh](https://img.shields.io/badge/Wazuh-SIEM-blue?style=for-the-badge)
![n8n](https://img.shields.io/badge/n8n-SOAR-ff6d5a?style=for-the-badge&logo=n8n&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-%232496ED.svg?style=for-the-badge&logo=docker&logoColor=white)

Este projeto implementa um **Centro de Operações de Segurança (SOC)** completo na AWS, provisionado via **Infraestrutura como Código (IaC)**. O diferencial é a arquitetura **SOAR** (Security Orchestration, Automation, and Response), capaz de detectar ataques e bloquear os invasores automaticamente no firewall da nuvem.

---

### 📋 Tabela de Conteúdos
1. [Arquitetura da Solução](#1-arquitetura-da-solução)
2. [Fluxo de Defesa](#2-fluxo-de-defesa)
3. [Desafios de Engenharia](#3-desafios-de-engenharia)
4. [Roadmap Executado](#4-roadmap-executado)
5. [Resultados e Evidências](#5-resultados-e-evidências)
6. [Como Reproduzir o Lab](#6-como-reproduzir-o-lab)
7. [Contato](#7-contato)

---

### **1. Arquitetura da Solução**

O ambiente é composto por:
* **Infraestrutura:** VPC Customizada, Subnets Públicas, Internet Gateway e Security Groups (AWS).
* **Wazuh (SIEM):** Responsável pela coleta de logs, análise de integridade e detecção de intrusão. Rodando em Docker.
* **n8n (Automação):** Responsável por orquestrar a resposta. Recebe o alerta do Wazuh e executa ações na AWS.
* **Máquina Vítima:** Instância EC2 vulnerável para testes de penetração.
* **Máquina Atacante:** Instância "Red Team" para simular invasões externas.

---

### **2. Fluxo de Defesa**

1.  **Ataque:** Um atacante tenta realizar *Brute Force SSH* contra a infraestrutura.
2.  **Detecção:** O Agente Wazuh identifica a anomalia e envia para o Manager.
3.  **Alerta:** O Wazuh gera um alerta de Nível 5+ e dispara um Webhook.
4.  **Orquestração:** O **n8n** recebe o JSON e extrai o IP do atacante via Regex.
5.  **Resposta:** O n8n chama a API da AWS e cria uma regra na **Network ACL** bloqueando o IP.
6.  **Notificação:** Um aviso detalhado é enviado para o canal do **Discord**.

---

### **3. Desafios de Engenharia**

Durante o desenvolvimento, superei limitações reais de ambiente Cloud:

| Desafio | Solução Aplicada |
| :--- | :--- |
| **Recursos Limitados** | Implementação de **4GB de Swap** para rodar a stack Java/Elastic do Wazuh em instância `t3.small` sem travar por OOM (Out of Memory). |
| **Instabilidade de Deploy** | Migração de scripts nativos para **Docker Containers**, garantindo isolamento e idempotência. |
| **Bloqueio de Hardware** | Contorno de restrições de conta AWS (que bloqueava instâncias maiores) através da otimização de software e expansão de disco EBS (20GB). |

---

### **4. Roadmap Executado**

- [x] **Fase 1: Infraestrutura (IaC)** - Provisionamento de rede e servidores com Terraform.
- [x] **Fase 2: Monitoramento** - Deploy do Wazuh Manager e Agentes.
- [x] **Fase 3: Detecção** - Criação de regras para identificar ataques SSH.
- [x] **Fase 4: Automação (SOAR)** - Integração Wazuh -> n8n -> AWS.
- [x] **Fase 5: Teste de Fogo** - Simulação real de ataque e validação do bloqueio automático.

---

### **5. Resultados e Evidências**

**🎥 O Ataque e o Bloqueio:**
*(Insira aqui o GIF ou Link do seu vídeo)*



### Desenvolvido por **Kaike Almeida**
🚀 *DevSecOps & Cloud Security Enthusiast*

[LinkedIn](https://www.linkedin.com/in/kaikealmeida) • [GitHub](https://github.com/Almeida013)

</div>