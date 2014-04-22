require 'spec_helper'

describe 'deleting posts' do
	context 'logged out' do
		before { create(:post) }

		describe 'attempting to delete posts' do
			it 'tells you to log in' do
				visit '/posts'
				click_link 'Delete'

				expect(page).to have_content 'Sign In'	
			end
		end
	end


	context 'logged in as Sarah' do
		let(:sarah) { create(:sarah) }

		before do
			login_as create(:sarah)
		end

		describe "attempting to delete Alex's post" do

			it 'displays an error' do
				sarah = create(:sarah)
				create(:post, user: sarah)

				visit '/posts'
				click_link 'Delete'

				expect(page).to have_content 'Error'	
			end
		end
 	
	 	describe 'deleting my own post' do 
		
			it 'removes the post' do
				create(:post, user: sarah)

				visit '/posts'
				click_link 'Delete'
				expect(page).to have_content 'Successfully deleted'
				expect(page).not_to have_content 'cool pic'
			end
		end
 	end
end


