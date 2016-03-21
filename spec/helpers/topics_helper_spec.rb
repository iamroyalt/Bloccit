require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TopicsHelper. For example:
#
# describe TopicsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TopicsHelper, type: :helper do
  def user_is_authorized_for_topics?
          current_user && current_user.admin?
     end
end
