require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsored_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 666) }

#1 CRUD - SHOW spec
  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :show
     end

    it "assigns my_post to @post" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
    end
  end
#2 CRUD - NEW spec
  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :new
    end

    it "instantiates @sponsored_post" do
      #get :new
       get :new, topic_id: my_topic.id, id: my_sponsored_post.id
       expect(assigns(:sponsored_post)).not_to be_nil
    end

       expects(assigns(:sponsored_post)).not_to_be_nil

end

#3 CRUD - Post spec
describe 'POST create' do
     it 'increases the number of SponsoredPosts by 1' do
       expect{post :create, topic_id: my_topic.id, my_sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(5..50)}}.to change(SponsoredPost,:count).by(1)
     end

     it 'assigns the new sponsored_post to @sponsored_post' do
       post :create, topic_id: my_topic.id, my_sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(5..50)}
       expect(assigns(:sponsored_post)).to eq SponsoredPost.last
      end
     it 'redirects to the new post' do
       post :create, topic_id: my_topic.id, my_sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(5..50)}
       expect(response).to redirect_to [my_topic, SponsoredPost.last]
     end
end

#4 CRUD - Edit spec
describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
        expect(response).to render_template :edit
    end

    it "assigns post to be updated to @sponsored_post" do
        get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
        sponsored_post_instance = assigns(:sponsored_post)

        expect(sponsored_post_instance.id).to eq my_sponsored_post.id
        expect(sponsored_post_instance.title).to eq my_sponsored_post.title
        expect(sponsored_post_instance.body).to eq my_sponsored_post.body
    end
end

#5 CRUD - update spec
describe 'PUT update' do
     it 'updates sponsored_post with expected attributes' do
       new_title = RandomData.random_word
       new_body = RandomData.random_paragraph
       new_price = rand(25..55)

       put :update, topic_id: my_topic.id, id: my_sponsored_post.id, post: {title: new_title, body: new_body, price: new_price}

       updated_post = assigns(:sponsored_post)

       expect(updated_post.title).to eq(new_title)
       expect(updated_post.body).to eq(new_body)
       expect(updated_post.price).to eq(new_price)
     end

     it 'redirects to the updated post' do
       new_title = RandomData.random_word
       new_body = RandomData.random_paragraph
       new_price = rand(25..55)

       put :update, topic_id: my_topic.id, id: my_sponsored_post.id, post: {title: new_title, body: new_body, price: new_price}
       expect(response).to redirect_to [my_topic, sponsored_post]
     end
   end
 #6 CRUD - destroy spec
   describe 'DELETE destroy' do
     it 'deletes the sponsored_post' do
       delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
       count = Post.where({id: sponsored_post.id}).size
       expect(count).to eq 0
     end

     it 'redirects to topic show' do
       delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
       expect(response).to redirect_to my_topic
     end
   end




end
