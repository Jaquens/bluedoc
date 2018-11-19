# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "base" do
    exist_user = create(:user, name: nil)

    user = build(:user, slug: exist_user.slug, name: nil)
    assert_equal false, user.valid?

    user = build(:user, slug: "Jason Lee", name: nil)
    assert_equal false, user.valid?

    user = build(:user, slug: "Jason-Lee_123", name: nil)
    assert_equal true, user.valid?

    user = build(:user, slug: "admin", name: nil)
    assert_equal true, user.valid?

    user = build(:user, slug: "Jason", name: nil)
    assert_equal true, user.valid?

    # slug unique with case insensitive
    user.save
    assert_equal false, user.new_record?
    assert_equal "Jason", user.slug
    assert_equal user.slug, user.to_param
    assert_equal "Jason", user.name

    # not auto format slug
    user = build(:user, slug: "Ruby on Rails")
    assert_equal false, user.valid?
    assert_equal "Ruby on Rails", user.slug
  end

  test "Slugable" do
    create(:user, slug: "huacnlee")

    user = User.find_by_slug("huacnlee")
    assert_not_nil user

    assert_equal user, User.find_by_slug!("huacnlee")
    assert_equal user, User.find_by_slug!("HuacnLee")

    assert_nil User.find_by_slug("huacnlee1")
    assert_raise(ActiveRecord::RecordNotFound) { User.find_by_slug!("huacnlee1") }

    user = build(:user, slug: "HuacnLee")
    assert_equal false, user.valid?
    assert_equal ["has already been taken"], user.errors[:slug]

    user = create(:user, slug: "JasonLee")
    assert_equal "JasonLee", user.slug
  end

  test "fullname" do
    u = build(:user, name: "Jason Lee", slug: "huacnlee")
    assert_equal "Jason Lee (huacnlee)", u.fullname
  end

  test "slug validation" do
    assert_equal true, build(:user, slug: "foo").valid?

    u = build(:user, slug: "new")
    assert_equal false, u.valid?
    assert_equal ["invalid or [#{u.slug}] is a keyword"], u.errors[:slug]
  end

  test ".repositories" do
    user = create(:user)
    repo0 = create(:repository, user_id: user.id)
    repo1 = create(:repository, user_id: user.id)

    group0 = create(:group)
    group0.add_member(user, :editor)
    repo2 = create(:repository, user_id: group0.id)

    group1 = create(:group)
    repo3 = create(:repository, user_id: group1.id)

    assert_equal 3, user.repositories.count
    assert_equal [repo0.id, repo1.id, repo2.id], user.repositories.pluck(:id).sort
  end

  test "to_path" do
    user = build(:user)
    assert_equal "/#{user.slug}", user.to_path
  end

  test "avatar_url" do
    user = create(:user)
    assert_match /\/images\/default-user-/, user.avatar_url
    group = create(:group)
    assert_match /\/images\/default-group-/, group.avatar_url
  end

  test "Groupable" do
    user = User.new
    assert_equal true, user.user?
    assert_equal false, user.group?

    group = Group.new
    assert_equal true, group.group?
    assert_equal false, group.user?
    assert_equal false, group.password_required?
    assert_equal false, group.email_required?
  end

  test "Prefix Search" do
    u0 = create(:user, slug: "jason")
    g0 = create(:group, slug: "jason-group")
    u1 = create(:user, name: "Jason")
    u2 = create(:user, email: "jason@com.com")
    u3 = create(:user, email: "Fooo@bar.com")

    users = User.prefix_search("ja")
    assert_equal 3, users.length
    ids = users.collect(&:id)
    assert_equal [u0.id, u1.id, u2.id].sort, ids.sort
  end

  test "destroy dependent :user_actives and :group_actives" do
    user0 = create(:user)
    user1 = create(:user)
    group = create(:group)

    UserActive.track(group, user: user0)
    UserActive.track(group, user: user1)
    assert_equal 1, UserActive.where(user_id: user0.id).count
    assert_equal 2, UserActive.where(subject_type: "User", subject_id: group.id).count

    user0.destroy
    assert_equal 0, UserActive.where(user_id: user0.id).count

    group.destroy
    assert_equal 0, UserActive.where(subject_type: "User", subject_id: group.id).count
  end

  test ".find_for_database_authentication" do
    user = create(:user, slug: "huacnlee", email: "huacnlee@gmail.com")
    assert_equal user, User.find_for_database_authentication(email: "huacnlee")
    assert_equal user, User.find_for_database_authentication(email: "HuacnLee")
    assert_equal user, User.find_for_database_authentication(email: "huacnlee@gmail.com")
    assert_equal user, User.find_for_database_authentication(email: "Huacnlee@Gmail.com")

    user = create(:user, slug: "Jason", email: "JASON@Gmail.com")
    assert_equal user, User.find_for_database_authentication(email: "jason")
    assert_equal user, User.find_for_database_authentication(email: "jason@gmail.com")
  end

  test "follows" do
    user = create(:user)
    other_user = create(:user)

    mock_current(user: user)

    user.follow_user(other_user)
    user.follow_user(user)

    other_user.reload
    user.reload
    assert_equal 1, other_user.followers_count
    assert_equal 1, user.following_count

    assert_equal 1, other_user.activities.where(action: "follow_user").count
    activity = other_user.activities.where(action: "follow_user").last
    assert_equal user.id, activity.actor_id

    assert_equal 1, user.follow_users.count
    assert_equal 1, other_user.follow_by_users.count

    user.unfollow_user(other_user)
    assert_equal 0, user.follow_users.count
    assert_equal 0, other_user.follow_by_users.count

    user1 = create(:user)
    user2 = create(:user)
    other_user1 = create(:user)
    user.stub(:follower_ids, [user1.id, user2.id]) do
      user.follow_user(other_user1)
      assert_equal 1, Activity.where(action: "follow_user", target: other_user1, actor_id: user.id, user_id: nil).count
      assert_equal 1, Activity.where(action: "follow_user", target: other_user1, user_id: user1.id).count
      assert_equal 1, Activity.where(action: "follow_user", target: other_user1, user_id: user2.id).count
      assert_equal 1, Activity.where(action: "follow_user", target: other_user1, user_id: other_user1.id).count
    end
  end

  test ".follower_ids" do
    user = create(:user)
    user1 = create(:user)
    user.follow_user(user1)

    assert_equal [user.id], user1.follower_ids
  end

  test "as_indexed_json" do
    user = create(:user, description: "Hello world")
    data = { sub_type: "user", slug: user.slug, title: user.name, body: "Hello world", user_id: user.id }
    assert_equal data, user.as_indexed_json

    group = create(:group)
    data = { sub_type: "group", slug: group.slug, title: group.name, body: group.description, user_id: group.id }
    assert_equal data, group.as_indexed_json
  end

  test "indexed_changed?" do
    user = create(:user)
    user = User.find(user.id)
    assert_equal false, user.indexed_changed?
    user.updated_at = Time.now
    user.followers_count += 1
    assert_equal false, user.indexed_changed?

    user.stub(:saved_change_to_name?, true) do
      assert_equal true, user.indexed_changed?
    end
    user.stub(:saved_change_to_description?, true) do
      assert_equal true, user.indexed_changed?
    end

    group = create(:group)
    group = Group.find(group.id)
    assert_equal false, group.indexed_changed?
    group.updated_at = Time.now
    group.followers_count += 1
    assert_equal false, group.indexed_changed?

    group.stub(:saved_change_to_name?, true) do
      assert_equal true, group.indexed_changed?
    end
    group.stub(:saved_change_to_description?, true) do
      assert_equal true, group.indexed_changed?
    end
  end

  test "System user" do
    assert_not_nil User.system
    assert_equal -1, User.system.id
    assert_equal "system", User.system.slug
    assert_equal "System", User.system.name
  end
end
