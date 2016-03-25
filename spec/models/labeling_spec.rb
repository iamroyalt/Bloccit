require 'rails_helper'

 RSpec.describe Labeling, type: :model do
 #we expect labelings to belong_to Labelable. Labelable is an interface. An interface is similar to a class in that it contains method definitions.
#The difference between an interface and a class is that an interface has no implementation of the methods which it defines.
   it { is_expected.to belong_to :labelable }
#lablelable is a polymorphic association...when one object can take the form of another object
#since a lable can belong to more than one model(database)we need the polymorphic association
 end
