require 'spec_helper'

describe Post do
	context 'validations' do 
		let(:post) { Post.new }

		specify 'description is required' do
			expect(post).to have(1).errors_on(:description)
		end

		describe '#tag_names' do 
			it "should create a tag if it does not exist" do 
				post = create(:post, tag_names: '#lol #wtf') #not sure I understand this part

				expect(post.tags.count).to eq 2
				expect(post.tags.first.name).to eq '#lol'
			end

			it "should use the tag if it already exists" do 
				post = Tag.create(name: '#fml')
				post = create(:post, tag_names: '#fml')

				expect(post.tags.count).to eq 1
				expect(post.tags.first.name).to eq '#fml'
				expect(Tag.count).to eq 1
			end

			it "keep tags unique" do 
				post = create(:post, tag_names: '#wtf #wtf')

				expect(post.tags.count).to eq 1
			end
		end
	end
end
