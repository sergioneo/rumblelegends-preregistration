class ReferralController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  	return_package = Hash.new
  	viewed_referrals = Referral.where(owner_wp_id: params[:id], viewed: 1)
    new_referrals = Referral.where(owner_wp_id: params[:id], viewed: 0)
    free_tickets = FreeTicket.where(owner_wp_id: params[:id], viewed: 0)
    prizes = FreeTicket.where(owner_wp_id: params[:id], viewed: 1)
  	member = Member.where(wp_id: params[:id]).first
  	if member.blank?
  		raise ActiveRecord::RecordNotFound, "Record not found."
  	end
  	return_package["referrals"] = viewed_referrals.map { |r| {"id": r.id, "type": r.category} }
    return_package["tickets"] = new_referrals.map { |r| {"id": r.id} }
    return_package["tickets"].concat(free_tickets.map {|r| {"id": r.id}})
  	return_package["promo_code"] = member.promo_code

    return_package["member_rank"] = Member.all.to_a.map { |m| {"username": m.username, "refs": Referral.where(owner_wp_id: m.wp_id).count}}.sort_by { |k| k[:refs] }.reverse.take(5)
    return_package["invited_friends"] = Referral.where(owner_wp_id: params[:id]).to_a.map { |r| {"username": Member.where(wp_id: r.referred_wp_id).first.username, "date": r.created_at.strftime("%d/%m/%Y")}}
    return_package["extra_prizes"] = prizes.map{|p| {"id": p.id, "type": p.category}}

  	render json: return_package
  end

  def view
    if  Referral.where(owner_wp_id: params[:id], viewed: 0).count == 0 and FreeTicket.where(owner_wp_id: params[:id], viewed: 0).count == 0
      render plain: "NO TICKETS"
      return
    end
    ref = Referral.where(owner_wp_id: params[:id], viewed: 0).first
    if ref.nil?
      ref = FreeTicket.where(owner_wp_id: params[:id], viewed: 0).first
    end
    ref.viewed = 1
    ref.save
    render plain: ref.category
  end
end
