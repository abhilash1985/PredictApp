# ApplicationHelper
module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end

  def amount_paid_tag(user, challenge)
    return if challenge.blank?
    paid = user.amount_paid_for(challenge)
    return unless paid
    image_tag 'paid.png', { size: '22x22', class: 'margin-left-5' }
  end
end
