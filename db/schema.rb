# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160904162113) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",                   null: false
    t.string   "password_digest"
    t.integer  "solved"
    t.integer  "submitted"
    t.integer  "status"
    t.string   "oj_name",         limit: 32
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "achievements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",        null: false
    t.string   "target",      null: false
    t.string   "description"
    t.string   "rank_title"
    t.integer  "score"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "article_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "article_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_tags_on_article_id", using: :btree
    t.index ["tag_id"], name: "index_article_tags_on_tag_id", using: :btree
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                                  null: false
    t.text     "content",      limit: 65535,             null: false
    t.integer  "user_id",                                null: false
    t.string   "article_type",                           null: false
    t.integer  "status",                                 null: false
    t.integer  "like_times",                 default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["user_id", "title"], name: "index_articles_on_user_id_and_title", unique: true, using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                  null: false
    t.string   "user_name",                                null: false
    t.string   "user_avatar"
    t.string   "description",      limit: 256,             null: false
    t.integer  "commentable_id",                           null: false
    t.string   "commentable_type",                         null: false
    t.integer  "parent_id"
    t.integer  "like_times",                   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  end

  create_table "honors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "contest_name",  null: false
    t.integer  "content_level", null: false
    t.string   "description"
    t.string   "team_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "filename",                    null: false
    t.string   "usage",                       null: false
    t.string   "description"
    t.boolean  "auth",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "submits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "pro_id",       limit: 32
    t.string   "run_id",       limit: 32
    t.integer  "run_time"
    t.integer  "memory"
    t.string   "lang",         limit: 32
    t.string   "result",       limit: 32
    t.text     "code",         limit: 65535
    t.datetime "submitted_at"
    t.integer  "status"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "oj_name",      limit: 32
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "name",                        null: false
    t.string   "nickname",                    null: false
    t.boolean  "gender"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "access_token"
    t.string   "password_digest"
    t.string   "avatar"
    t.integer  "role"
    t.string   "stu_id"
    t.integer  "status",          default: 0
    t.string   "phone"
    t.string   "school"
    t.string   "college"
    t.string   "major"
    t.string   "grade"
    t.string   "description"
    t.string   "situation"
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  end

end
