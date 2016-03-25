class Label < ActiveRecord::Base

   has_many :labelings
   has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
   has_many :posts, through: :labelings, source: :labelable, source_type: :Post

   def self.update_labels(label_string)
 #return if the label_string passed in is a blank
     return Label.none if label_string.blank?

 #update_labels splits up the label_string which is how we are storing our labels on the backend by splitting the string on a comma
 #For each label, we call find_or_create using the label name. This ensures we never create a duplicate label
     label_string.split(",").map do |label|
       Label.find_or_create_by(name: label.strip)
     end
   end
 end
