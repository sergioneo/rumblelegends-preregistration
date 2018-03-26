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
  	member = Member.new
  	member.wp_id = params[:id]
  	member.promo_code = ('a'..'z').to_a.shuffle[0,10].join
  	member.save
  	render plain: "OK"
  end
end
