class ReferralController < ApplicationController
  def index
  	return_package = Hash.new
  	referrals = Referral.where(owner_wp_id: params[:id])
  	member = Member.where(wp_id: params[:id]).first
  	if member.blank?
  		raise ActiveRecord::RecordNotFound, "Record not found."
  	end
  	return_package["referrals"] = referrals.map { |r| {"id": r.id, "type": r.category} }
  	return_package["promo_code"] = member.promo_code
  	render json: return_package
  end

  def add
  	ref = Referral.new
  	ref["owner_wp_id"] = params["sender"]
  	ref["referred_wp_id"] = params["referred"]
  	numero = SecureRandom.random_number(10000)
  	ref["category"] = 0
  	if numero == 9999
  		ref["category"] = 2
  	elsif numero >= 9000
  		ref["category"] = 1
  	end
  	ref.save
  	render plain: "OK"
  end
end
