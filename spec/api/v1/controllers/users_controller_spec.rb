require 'rails_helper'

 RSpec.describe Api::V1::UsersController, type: :controller do
   let(:my_user) { create(:user) }


   context "unauthenticated users" do
     it "GET index returns http unauthenticated" do
       get :index
       expect(response).to have_http_status(401)
     end

     it "GET show returns http unauthenticated" do
       get :show, id: my_user.id
       expect(response).to have_http_status(401)
     end
#Checkpoint-49 expect unauthenticated request to teh user update and create actions will return 401 unauthorized
     it "PUT update returns http unauthenticated" do
       new_user = build(:user)
       put :update, id: my_user.id, user: { name: new_user.name, email: new_user.email, password: new_user.password }
       expect(response).to have_http_status(401)
     end

     it "POST create returns http unauthenticated" do
       new_user = build(:user)
       post :create, user: { name: new_user.name, email: new_user.email, password: new_user.password }
       expect(response).to have_http_status(401)
     end
   end


   context "authenticated and unauthorized users" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

     it "GET index returns http forbidden" do
       get :index
       expect(response).to have_http_status(403)
     end

     it "GET show returns http forbidden" do
       get :show, id: my_user.id
       expect(response).to have_http_status(403)
     end

#Checkpoint-49 expect that non-admin requests to the user update and create actions will return 403 forbidden
     it "PUT update returns http forbidden" do
       new_user = build(:user)
       put :update, id: my_user.id, user: { name: new_user.name, email: new_user.email, password: new_user.password }
       expect(response).to have_http_status(403)
     end

     it "POST create returns http forbidden" do
       new_user = build(:user)
       post :create, user: { name: new_user.name, email: new_user.email, password: new_user.password }
       expect(response).to have_http_status(403)
     end
   end


   context "authenticated and authorized users" do
     before do
       my_user.admin!
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

     describe "GET index" do
       before { get :index }

       it "returns http success" do
         expect(response).to have_http_status(:success)
       end


       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end

       it "returns my_user serialized" do
         expect(response.body).to eq([my_user].to_json)
       end
     end


     describe "GET show" do
       before { get :show, id: my_user.id }

       it "returns http success" do
         expect(response).to have_http_status(:success)
       end

       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end

       it "returns my_user serialized" do
         expect(response.body).to eq(my_user.to_json)
       end
     end

#Checkpoint-49 new describe section for updating a user and testing behavior for update
     describe "PUT update" do
            context "with valid attributes" do
              before do
      #build @new_user using FactoryGirl
                @new_user = build(:user)
      #before each spec, send a request to update my_user using the attributes of @new_user
                put :update, id: my_user.id, user: { name: @new_user.name, email: @new_user.email, password: @new_user.password, role: "admin" }
              end

      #expect a successful request will return an HTTP success code and a JSON response
              it "returns http success" do
                expect(response).to have_http_status(:success)
              end

              it "returns json content type" do
                expect(response.content_type).to eq 'application/json'
              end

      #test that we updated the user by comparing our expected attributes with the attributes returned in the JSON message by update
              it "updates a user with the correct attributes" do
                hashed_json = JSON.parse(response.body)
                expect(hashed_json["name"]).to eq(@new_user.name)
                expect(hashed_json["email"]).to eq(@new_user.email)
                expect(hashed_json["role"]).to eq("admin")
              end
            end

      #expect that an update with invalid user attributes will return a 400 bad request status code with JSON error message
            context "with invalid attributes" do
              before do
                put :update, id: my_user.id, user: { name: "", email: "bademail@", password: "short" }
              end

              it "returns http error" do
                expect(response).to have_http_status(400)
              end

              it "returns the correct json error message" do
                expect(response.body).to eq({ error: "User update failed", status: 400 }.to_json)
              end
            end
          end

#Checkpoint-49 adding test for creating users
          describe "POST create" do
                 context "with valid attributes" do
                   before do
           #build @new_user using Factory Girl and send a request to create a new user
                     @new_user = build(:user)
                     post :create, user: { name: @new_user.name, email: @new_user.email, password: @new_user.password, role: "admin" }
                   end

           #expect a success request will return an HTTP success code
                   it "returns http success" do
                     expect(response).to have_http_status(:success)
                   end

                   it "returns json content type" do
                     expect(response.content_type).to eq 'application/json'
                   end

                   it "creates a user with the correct attributes" do
                     hashed_json = JSON.parse(response.body)
                     expect(hashed_json["name"]).to eq(@new_user.name)
                     expect(hashed_json["email"]).to eq(@new_user.email)
                     expect(hashed_json["role"]).to eq("admin")
                   end
                 end

           #expect an update with invalid user attributes will return a 400 Bad request status code
                 context "with invalid attributes" do
                   before do
                     post :create, user: { name: "", email: "bademail@", password: "short" }
                   end

                   it "returns http error" do
                     expect(response).to have_http_status(400)
                   end

                   it "returns the correct json error message" do
                     expect(response.body).to eq({ "error": "User is invalid", "status": 400 }.to_json)
                   end
                 end
               end

   end
 end
