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

  context 'time created' do 
  	before do
  		Post.create(title: 'Here is a picture')
  	end
  	it 'is displayed with a post' do 
  		visit '/posts'
  		expect(page).to have_content('less than a minute ago')
  	end
  end

  describe 'creating posts' do 
    
    context 'logged out' do 
    	it 'should prompt to sign in' do 
    		visit '/posts'
    		click_link 'Add a post'
    		expect(page).to have_content 'Sign up'
    	end
    end

    context 'logged in' do 
    	before do
    		visit '/users/sign_up'
    		fill_in 'user[email]', with: 'a@a.com'
    		fill_in 'user[password]', with: '12345678'
    		fill_in 'user[password_confirmation]', with: '12345678'
    		click_button 'Sign up'
    	end

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
  end

  describe 'editing posts' do 
  	before do
  		michelle = User.create(email: 'a@a.com', password: '12345678', password_confirmation: '12345678')
  	  login_as michelle 
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
  		michelle = User.create(email: 'a@a.com', password: '12345678', password_confirmation: '12345678')
  	  login_as michelle 
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
