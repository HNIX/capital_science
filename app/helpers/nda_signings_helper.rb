module NdaSigningsHelper
  def fill_nda_content(content, listing, user)
	nda = ''
	nda = content.to_s
	# content.to_s.gsub('[user_name]', user.name)
	# content.to_s.gsub('[account_name]', listing.account.name)
	nda.gsub!("[listing]", listing.title)
	nda.gsub!("[user_name]", current_user.name)
	nda.gsub!("[account_name]", listing.account.name)
	nda.gsub!("[date]", Time.now.strftime("%m/%d/%Y"))
	nda
  end
end
