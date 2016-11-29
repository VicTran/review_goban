module UsersHelper
  def gravatar_for user, options = {size: 50}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    if user.picture?
      gravatar_url = user.picture.url
      image_tag gravatar_url, size: size,
        alt: user.name, class: "gravatar"
    else
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag gravatar_url, alt: user.name, class: "gravatar"
    end
  end

  def show_user_picture user
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    if user.picture?
      gravatar_url = user.picture.url
      image_tag gravatar_url, height: 200, width: 200, alt: User.name, class: "img-circle"
    else
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{100}"
      image_tag gravatar_url, alt: user.name, class: "gravatar img-circle"
    end
  end
end
