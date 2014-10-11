require 'rails_helper'

describe 'posts' do 
  
  context 'no posts have been added' do 
  	it 'should display a prompt to add a post' do 
  		visit '/posts'
  		expect(page).to have_content "No posts yet"
  		expect(page).to have_link "Add a post"
    end
  end 

  context 'posts have been added' do 
  	before do 
  		Post.create(title: 'Here is a picture')
  	end
  	it 'should display them' do
  		visit '/posts'
  		expect(page).to have_content('Here is a picture')
  		expect(page).not_to have_content('No posts yet')
  	end
  end

  describe 'creating posts' do 
  	it 'prompts user to upload picture and fill in title, then displays a new post' do 
      visit '/posts'
      click_link 'Add a post'
      fill_in 'Title', with: 'Here is a picture'
      attach_file 'Image', Rails.root.join('spec/images/photo.jpg')
      click_button 'Create Post'
      expect(page).to have_content 'Here is a picture'
      # expect(page).to have_css 'photo.jpg'
      expect(current_path).to eq '/posts'
  	end 
  end

  describe 'editing posts' do 
  	before do
  	  Post.create(title: 'Here is a picture') 
  	end
  	it 'can allow a user to edit a post' do 
	    visit '/posts'
	    click_link 'Edit'
	    fill_in 'Title', with: 'This is my picture'
	    click_button 'Update Post'
	    expect(page).to have_content 'This is my picture'
	    expect(current_path).to eq '/posts'
	  end
  end

  describe 'deleting posts' do 
  	before do 
      Post.create(title: 'Here is a picture')
    end
    it 'removes a post when a user clicks a delete link' do 
      visit '/posts'
      click_link 'Delete'
      expect(page).not_to have_content 'Here is a picture'
      expect(page).to have_content 'Post successfully deleted'
    end    
  end
end 
