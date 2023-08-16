# via_cep_app

Este projeto tem como objetivo demonstrar os conhecimentos de Flutter fazendo requisições HTTP e salvando as informações no banco local do telefone utilzando o Sqlite.

## Começando

O projeto precisa de algumas coisas instaladas como:

- Sqflite
- dio
- path

Estas informações serão vistas no arquivo
``` /pubspec.yaml ```


## Funcionalidades

O app tem duas funcionalidades:

### Primeira
Efetuar buscas HTTP utilizando [Dio](https://pub.dev/packages/dio) para a API do [ViaCEP](https://viacep.com.br/)
assim se consegue conferir qual o endereço através do CEP passado.

### Segunda
Criar um Histórico de pesquisas feitas com algumas informações exenciais como:
    ``` 
        {
            cep,
            logradouro,
            bairro,
            localidade,
            uf
        }
    ```
Estas informações são salvas utilizando [Sqflite](https://pub.dev/packages/sqflite) conhecido como Sqlite para Flutter, 
posteriormente são mostradas na página de listagem CEP onde é possivel ver essas informações e além disso deletar alguma das pesquisas feitas

## Referências
(ViaCep)[https://viacep.com.br/]
