require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
     #let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
     #let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld", role: :member) }
     #let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
     #let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
    let(:my_topic) { create(:topic) }
    let(:my_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:my_post) { create(:post, topic: my_topic, user: my_user) }
    let(:my_comment) { Comment.create!(body: 'Comment Body', post: my_post, user: my_user) }

   #create a spec for guest users who will be redirected to sign in if they attempt to create or delete a comment
     context "guest" do
       describe "POST create" do
         it "redirects the user to the sign in view" do
#Checkpoint-47 adding test to expect create action to respond to javascript requests
           post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
           expect(response).to redirect_to(new_session_path)
         end
       end

       describe "DELETE destroy" do
         it "redirects the user to the sign in view" do
#Checkpoint-47 adding test to expect delete action to respond to javascript requests
           delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
           expect(response).to redirect_to(new_session_path)
         end
       end
     end

   #create specs for member users who attempt to create new comments or delete comments they don't own
     context "member user doing CRUD on a comment they don't own" do
       before do
         create_session(other_user)
       end

       describe "POST create" do
         it "increases the number of comments by 1" do
#Checkpoint-47 adding test to expect create action to respond to javascript requests
           expect{ post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
         end

         it "returns http success" do
         post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
         expect(response).to have_http_status(:success)

       end

       describe "DELETE destroy" do
         it "redirects the user to the posts show view" do
#Checkpoint-47 adding test to expect delete action to respond to javascript requests
           delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
           expect(response).to redirect_to([my_topic, my_post])
         end
       end
     end


   #test that member users are able to create new comments and delete their own comments
     context "member user doing CRUD on a comment they own" do
       before do
         create_session(my_user)
       end

       describe "POST create" do
         it "increases the number of comments by 1" do
#Checkpoint-47 adding test to expect create action to respond to javascript requests
           expect{ post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
         end

         it "returns http success" do
         post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
         expect(response).to have_http_status(:success)
       end
    end
       describe "DELETE destroy" do
         it "deletes the comment" do
#Checkpoint-47 adding test to expect delete action to respond to javascript requests
           delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
           count = Comment.where({id: my_comment.id}).count
           expect(count).to eq 0
         end
#Checkpoint-47 no longer expect destroy action will redirect to the post show view..instead we expect to receive HTTP success
         it "returns http success" do
         delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
         expect(response).to have_http_status(:success)
         end
       end
     end


     context "admin user doing CRUD on a comment they don't own" do
       before do
         other_user.admin!
         create_session(other_user)
       end

       describe "POST create" do
         it "increases the number of comments by 1" do
#Checkpoint-47 adding test to expect create action to respond to javascript requests
         expect{ post :create, format: :js,  post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
         end

         it "returns http success" do
         post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence}
         expect(response).to have_http_status(:success)
         end
       end

       describe "DELETE destroy" do
         it "deletes the comment" do
#Checkpoint-47 adding test to expect delete action to respond to javascript requests,
           delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
           count = Comment.where({id: my_comment.id}).count
           expect(count).to eq 0
         end
#Checkpoint-47 no longer expect destroy action will redirect to the post show view..instead we expect to receive HTTP success
         it "returns http success" do
         delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
         expect(response).to have_http_status(:success)


         end
       end
     end
  end
