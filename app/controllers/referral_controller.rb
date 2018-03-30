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
end
