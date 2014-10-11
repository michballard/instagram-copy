require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe '#tag_list=' do 
  	let(:post) { Post.create(title: 'Example post')}
    
    context 'no tags provided' do 
      it 'gives 0 tags to the post' do 
        post.tag_list = ''
        expect(post.tags).to be_empty
      end 
    end

    context '1 tag' do 
      it 'adds that tag to our post' do 
      	post.tag_list = '#test'
      	expect(post.tags.first.text).to eq '#test'
      end
    end
    
    context 'multiple tags' do 
    	it 'adds all the tags seperately' do 
        post.tag_list = '#test, #picture'
        expect(post.tags.count).to eq 2
    	end
    end 

    context 'reusing tags' do 
    	before { Tag.create(text: '#test')}

    	it 'reuses them' do 
        post.tag_list = '#test, #picture'
        expect(Tag.count).to eq 2
	    end
    end 

    context 'with duplicate tags' do 
      it 'de-duplicates them' do 
        post.tag_list = '#test, #picture, #test'
        expect(post.tags.count).to eq 2
      end
    end
  end
end
