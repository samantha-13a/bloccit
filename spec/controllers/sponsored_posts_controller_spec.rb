require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsoredpost) { my_topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 50) }

describe "GET show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(response).to render_template :show
    end
 
    it "assigns my_sponsoredpost to @sponsoredpost" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(assigns(:sponsoredpost)).to eq(my_sponsoredpost)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end

    it "instantiates @sponsoredpost" do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:sponsoredpost)).not_to be_nil
    end
  end

  describe "SPONSOREDPOST create" do
    it "increases the number of Sponsoredpost by 1" do
      expect{ sponsoredpost :create, params: { topic_id: my_topic.id, sponsoredpost: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 50 } } }.to change(Sponsoredpost,:count).by(1)
    end

    it "assigns the new post to @sponsoredpost" do
      sponsoredpost :create, params: { topic_id: my_topic.id, sponsoredpost: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 50 } }
      expect(assigns(:sponsoredpost)).to eq Sponsoredpost.last
    end

    it "redirects to the new sponsoredpost" do
      sponsoredpost :create, params: { topic_id: my_topic.id, sponsoredpost: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 50 } }
      expect(response).to redirect_to [my_topic, Sponsoredpost.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(response).to have_http_status(:success)
    end
 
    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(response).to render_template :edit
    end
 
    it "assigns sponsored post to be updated to @sponsoredpost" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
 
      sponsoredpost_instance = assigns(:sponsoredpost)
 
      expect(sponsoredpost_instance.id).to eq my_sponsoredpost.id
      expect(sponsoredpost_instance.title).to eq my_sponsoredpost.title
      expect(sponsoredpost_instance.body).to eq my_sponsoredpost.body
      expect(sponsoredpost_instance.price).to eq my_sponsoredpost.price 
    end
  end

  describe "PUT update" do
    it "updates sponsoredpost with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 50
 
      put :update, params: { topic_id: my_topic.id, id: my_sponsoredpost.id, sponsoredpost: {title: new_title, body: new_body, price: new_price } }
 
      updated_sponsoredpost = assigns(:sponsoredpost)
      expect(updated_sponsoredpost.id).to eq my_sponsoredpost.id
      expect(updated_sponsoredpost.title).to eq new_title
      expect(updated_sponsoredpost.body).to eq new_body
      expect(updated_sponsoredpost.price).to eq new_price 
    end
 
    it "redirects to the updated sponsoredpost" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 50
 
      put :update, params: { topic_id: my_topic.id, id: my_sponsoredpost.id, sponsoredpost: {title: new_title, body: new_body, price: new_price } }
      expect(response).to redirect_to [my_topic, my_sponsoredpost]
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsoredpost" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      count = Sponsoredpost.where({id: my_sponsoredpost.id}).size
      expect(count).to eq 0
    end
 
    it "redirects to topic show" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_sponsoredpost.id }
      expect(response).to redirect_to my_topic 
    end
  end

end