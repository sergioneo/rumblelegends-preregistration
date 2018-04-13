class LinkController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  	existing = Link.where(code: params["id"])
  	if existing.count == 1
  		ext = existing.first
  		ext.hits = ext.hits + 1
  		ext.save
  		redirect_to ext.original_url
  	else
  		render status: 404
  	end
  end


  def post

  	existing = Link.where(original_url: "https://www.rumblelegends.com/register?ref_by="+params["id"])

  	if existing.count == 1
  		render plain: request.base_url+"/l/"+existing.first.code
  	else
	  	l = Link.new
	  	l["original_url"] = "http://www.rumblelegends.com/register?ref_by="+params["id"]
	  	l["hits"] = 0
	  	l["code"] = ('a'..'z').to_a.shuffle[0,12].join
	  	l.save
	  	render plain: request.base_url+"/l/"+l["code"]
	  end
  end
end
