require 'spec_helper'

describe 'posts index page' do

	context 'no posts have been added' do
		it 'displays a warning message' do
			visit '/posts'
			expect(page).to have_content 'No posts yet'
		end
	end

	describe 'adding a post' do
		context 'valid post' do # why put the context here?
			it 'is added to the posts page' do
				visit '/posts/new'
				fill_in 'Description', with: 'Awesome pic'
				click_button 'Create Post'

				expect(current_path).to eq '/posts'
				expect(page).to have_content	'Awesome pic'
			end
		end

		context 'invalid post' do
			it 'raises an error' do
				visit '/posts/new'
				click_button 'Create Post'
	
				expect(page).to have_content 'error'
			end
		end

		describe 'with tags' do 
			it 'adds the tag with the post' do
				visit '/posts/new'
				fill_in 'Description', with: 'cool pic'
				fill_in 'Tags', with: '#fml, #wtf'
				click_button 'Create Post'

				expect(page).to have_content '#fml, #wtf'
			end
		end

	end


	context 'with posts' do
		before { create(:post) }

		describe 'display post' do
			it 'displays post' do
				visit '/posts'
				expect(page).to have_content('cool pic')
			end
		end

		describe 'deleting a post' do 
			it 'permenantly deletes a post' do
				visit '/posts'
				click_link 'Delete'
	
				expect(page).not_to have_content 'cool pic'
			end
		end

	end

	context 'with post with tags' do 
		before do
			create(:post, tag_names: '#wtf #fml')
			create(:post, description: 'Hello world')
		end

		describe 'clicking a tag' do
			it 'shows the photos for that tag' do
				visit '/posts'
				click_link '#wtf'
				expect(page).to have_content 'cool pic'
			end

			it 'does not show photos without that tag' do 
				visit '/posts'
				click_link '#wtf'
				expect(page).not_to have_content 'Hello world'
			end

			it 'uses a pretty URL' do 
				visit '/posts'
				click_link '#wtf'

				expect(current_path).to eq '/tags/wtf'
			end
		end
	end
end