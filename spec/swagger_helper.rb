# frozen_string_literal: true
require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.3',
      info: {
        title: 'API сервиса для тестового задания',
        version: '0.1.0'
      },
      paths: {},
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            description: 'Ожидается токен, выдаваемый при регистрации студента',
            bearerFormat: :SHA256
          }
        },
        schemas: {
          Student: {
            type: :object,
            properties: {
              id: { type: :integer },
              first_name: { type: :string },
              last_name: { type: :string },
              surname: { type: :string },
              school_id: { type: :integer },
              class_id: { type: :integer }
            },
            required: %w[id first_name last_name surname school_id class_id]
          },
          Class: {
            type: :object,
            properties: {
              id: { type: :integer },
              number: { type: :integer },
              letter: { type: :string },
              students_count: { type: :integer }
            },
            required: %w[id number letter students_count]
          },
          School: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string }
            }
          }
        }
      }
    }
  }

  config.openapi_format = :yaml
end