# Elixpay
![Test coverage badge](https://img.shields.io/coveralls/github/savioacp/elixpay)

## Overview

Este projeto foi criado ao acompanhar a Next Level Week #4. O nome do projeto foi trocado para Elixpay para melhor representar o objetivo do projeto. O nome original é Rocketpay.


## Iniciando o projeto

  * Configure um servidor Postgres em `localhost` com crecenciais `postgres:postgres`
  * `mix deps.get`
  * `mix ecto.setup`
  * `mix phx.server`

A API estará escutando na porta 4000.

## Competências adquiridas

  * Ecto:
    * Schemas
    * Migrations 
    * Transactions
    * Ecto Multi
  * Phoenix:
    * Controllers
    * Views
    * Fallback Controllers
  * Testes
    * ExUnit
    * ConnCase
    * DataCase
    * Coveralls
