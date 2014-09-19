module SampleModels

  # An ActiveFedora::Base object with private access
  def private_object
    ActiveFedora::Base.create
    # apply access controls metdata for private access
    # return object
  end

  # An ActiveFedora::Base object with public access
  def public_object
    ActiveFedora::Base.create
    # apply access controls metdata for public access
    # return object
  end

end
