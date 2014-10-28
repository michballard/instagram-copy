require 'rails_helper'

describe 'tagging posts' do 

  before do 
  	michelle = User.create(email: 'a@a.com', password: '12345678', password_confirmation: '12345678')
  	login_as michelle 
  end
  it 'displays tags as links under posts' do 
    visit '/posts'
    click_link 'Add a post'
    fill_in 'Title', with: 'Here is a picture'
    fill_in 'Tags', with: '#test, #picture'
    attach_file 'Image', Rails.root.join('spec/images/photo.jpg')
    click_button 'Create Post'
    expect(page).to have_link '#test'
    expect(page).to have_link '#picture'
  end
end

describe 'filtering by tags' do 
  before do
  	Post.create(title: 'Post A', tag_list: '#test, #hello')
  	Post.create(title: 'Post B', tag_list: '#test, #fun')
  end

  it 'filters to show only tagged posts' do 
  	visit '/posts'
  	click_link '#hello'
  	expect(page).to have_css 'h3', text: 'Posts tagged with #hello'
  	expect(page).to have_content 'Post A'
  	expect(page).not_to have_content 'Post B'
  end 

  it 'accessible by pretty URLs' do 
  	visit '/tags/hello'
  	expect(page).to have_content 'Post A'  	
  end
end
