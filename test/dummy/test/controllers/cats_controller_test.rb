require 'test_helper'

class CatsControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  test "index" do
    get '/cats'
    assert_response :success
    assert_match "1", @response.body

    100.times do |i|
      Cat.create(name: "cat#{i}")
    end
    get cats_url
    assert_match "100", @response.body

    get cats_url, params: {qs_sorts: 'created_at asc'}
    assert_match "1", "#{JSON.parse(@response.body)['items'].first['id']}"

    get cats_url, params: {qs_sorts: 'created_at desc'}
    assert_match "100", "#{JSON.parse(@response.body)['items'].first['id']}"

    get cats_url, params: {qs_sorts: ['created_at desc']}
    assert_match "100", "#{JSON.parse(@response.body)['items'].first['id']}"
  end

  test "create" do
    post '/cats', params: { name: "FIFA" }
    assert_response :success

    post '/cats', params: { name: "" }
    assert_match "can't be blank", @response.body
  end

  test "update" do
    cat = Cat.create(name: '1')
    put "/cats/#{cat.id}", params: {name: 'n2'}
    assert_match "successfully", @response.body

    put "/cats/#{cat.id}", params: {name: ''}
    assert_match "can't be blank", @response.body

    cat = Cat.create(name: '2')
    put "/cats/#{cat.id}", params: {name: 'n2'}
    assert_match "has already been taken", @response.body
  end

  test "show" do
    cat = Cat.create(name: '1')
    get "/cats/#{cat.id}"
    assert_match "id", @response.body
  end
end
