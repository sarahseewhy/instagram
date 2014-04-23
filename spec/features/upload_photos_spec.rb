require 'spec_helper'

describe 'Uploading photos' do 
	before do
		login_as create(:sarah)
	end
	
	it 'displays the image on the post page' do 
		visit '/posts/new'
		fill_in 'Description', with: 'Awesome pic'
		attach_file 'Picture', Rails.root.join('spec/images/grumpycat.jpg')
		click_button 'Create Post'


		expect(page).to have_css 'img.uploaded-pic'
	end
end
