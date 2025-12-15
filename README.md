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
> *[(Insira aqui seu GIF ou Link do vídeo mostrando o terminal do atacante travando)](https://share.zight.com/Apu290wA)*


### Desenvolvido por **Kaike Almeida**
🚀 *DevSecOps & Cloud Security Enthusiast*

[LinkedIn](https://www.linkedin.com/in/kaikealmeida) • [GitHub](https://github.com/Almeida013)

</div>
