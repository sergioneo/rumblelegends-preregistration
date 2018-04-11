class MemberController < ApplicationController

skip_before_action :verify_authenticity_token
  def register
  	if params[:id].blank?
  		raise ActiveRecord::RecordNotFound, "Record not found."
  	end
  	if Member.where(wp_id: params[:id]).length > 0
  		render plain: "USER EXISTS"
  		return
  	end
    if params[:id] != Digest::SHA1.hexdigest(params[:username]+"subscriber")
      render plain: "INVALID ID"
      return
    end
  	member = Member.new
  	member.wp_id = params[:id]
    member.username = params[:username]
  	member.promo_code = ('a'..'z').to_a.shuffle[0,10].join
  	member.save

  	if !params["ref_me"].blank?
  		ref = Referral.new
	  	ref["owner_wp_id"] = params["ref_me"]
	  	ref["referred_wp_id"] = params[:id]
	  	numero = SecureRandom.random_number(10000)
      ref["viewed"] = 0
	  	ref["category"] = 0
	  	if numero == 0
	  		ref["category"] = 2
	  	elsif numero <= 34
	  		ref["category"] = 1
	  	end
	  	ref.save
  	end

  	render plain: "OK"
  end
end
