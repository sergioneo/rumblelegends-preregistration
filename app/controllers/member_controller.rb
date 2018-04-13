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

    ft = FreeTicket.new
    ft.owner_wp_id = params[:id]
    numero = SecureRandom.random_number(1000)
    ft.viewed = 0
    ft.category = 0
    if numero == 0
      ft.category = 2
    elsif numero <= 34
      ft.category = 1
    end
    ft.save

  	if !params["ref_me"].blank?
  		ref = Referral.new
	  	ref["owner_wp_id"] = params["ref_me"]
	  	ref["referred_wp_id"] = params[:id]
	  	numero = SecureRandom.random_number(1000)
      ref["viewed"] = 0
	  	ref["category"] = 0
	  	if numero == 0
	  		ref["category"] = 2
	  	elsif numero <= 34
	  		ref["category"] = 1
	  	end
	  	ref.save

      if Referral.where(owner_wp_id: params["ref_me"]).count == 10
        ft = FreeTicket.new
        ft.viewed = 1
        ft.owner_wp_id = params["ref_me"]
        ft.category = 1
        ft.save
      elsif Referral.where(owner_wp_id: params["ref_me"]).count == 100
        ft = FreeTicket.new
        ft.viewed = 1
        ft.owner_wp_id = params["ref_me"]
        ft.category = 2
        ft.save
      end
  	end

  	render plain: "OK"
  end
end
