require "swagger_helper"

RSpec.describe "api/v1/contacts", type: :request do
  path "/api/v1/users/{user_id}/contacts" do
    parameter name: "user_id", in: :path, type: :string, description: "user_id"

    get("list contacts") do
      response(200, "successful") do
        let(:user_id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post("create contact") do
      response(200, "successful") do
        let(:user_id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path "/api/v1/users/{user_id}/contacts/{id}" do
    # You'll want to customize the parameter types...
    parameter name: "user_id", in: :path, type: :string, description: "user_id"
    parameter name: "id", in: :path, type: :string, description: "id"

    get("show contact") do
      response(200, "successful") do
        let(:user_id) { "123" }
        let(:id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch("update contact") do
      response(200, "successful") do
        let(:user_id) { "123" }
        let(:id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put("update contact") do
      response(200, "successful") do
        let(:user_id) { "123" }
        let(:id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete("delete contact") do
      response(200, "successful") do
        let(:user_id) { "123" }
        let(:id) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
