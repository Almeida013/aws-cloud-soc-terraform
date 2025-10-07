# Projeto: SOC na Nuvem com IaC (Infrastructure as Code)

## 1. Objetivo

Este projeto demonstra a construção de um Centro de Operações de Segurança (SOC) funcional e de baixo custo na AWS. A solução é totalmente provisionada via Terraform e utiliza ferramentas open-source como Wazuh e PFSense para monitorar, detectar e alertar sobre atividades de segurança em tempo real.

O objetivo é resolver a falta de visibilidade de segurança em ambientes de nuvem, criando um sistema de defesa proativo a partir do zero.

## 2. Arquitetura da Solução

*A ser preenchido com um diagrama da nossa infraestrutura final.*

![Arquitetura Placeholder](https://via.placeholder.com/800x450.png?text=Diagrama+da+Arquitetura+AWS)

## 3. Stack Tecnológica

* **Cloud Provider:** AWS
* **Infrastructure as Code:** Terraform
* **SIEM / EDR:** Wazuh
* **Firewall / Roteador:** PFSense
* **Sistema Operacional:** Linux (Ubuntu/Debian)

## 4. Como Executar

1.  Clone este repositório.
2.  Configure suas credenciais da AWS.
3.  Execute `terraform init`.
4.  Execute `terraform plan`.
5.  Execute `terraform apply`.

## 5. Resultados e Provas de Conceito (PoC)

Nesta seção, serão demonstrados os resultados dos testes de segurança realizados.

### Teste 1: Detecção de Brute-Force RDP

*A ser preenchido com o screenshot do ataque e do alerta no Wazuh.*

### Teste 2: Detecção de Varredura de Portas

*A ser preenchido com o screenshot do ataque e do alerta no Wazuh.*