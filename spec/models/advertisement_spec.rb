require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) {advertisement.create!(title: "New Advertisement", body: "Here is the offer", price:50) }

   describe "attributes" do

     it "responds to title" do
       expect(advertisement).to respond_to(:title)
     end

     it "responds to body" do
       expect(advertisement).to respond_to(:body)
     end

     it "responds to price" do
       expect(advertisement).to respond_to(:price)
     end
end

end
