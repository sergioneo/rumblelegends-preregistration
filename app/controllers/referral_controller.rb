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

    return_package["member_rank"] = Member.all.to_a.map { |m| {"username": m.username, "refs": Referral.where(owner_wp_id: m.wp_id).count}}.sort_by { |k| k[:refs] }.reverse.take(5)
    return_package["invited_friends"] = Referral.where(owner_wp_id: params[:id]).to_a.map { |r| {"username": Member.where(wp_id: r.referred_wp_id).first.username, "date": r.created_at}}

  	render json: return_package
  end
end
