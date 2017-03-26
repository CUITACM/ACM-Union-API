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

ActiveRecord::Schema.define(version: 20170320031822) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",                     null: false
    t.string   "password_digest", limit: 1024
    t.integer  "solved"
    t.integer  "submitted"
    t.integer  "status"
    t.string   "oj_name",         limit: 32
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "achievements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                           null: false
    t.string   "description",      limit: 2048
    t.integer  "score"
    t.string   "achievement_type"
    t.integer  "parent_id"
    t.integer  "prev_id"
    t.text     "conditions",       limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
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
    t.string   "article_type",                           null: false
    t.integer  "status",                                 null: false
    t.integer  "like_times",                 default: 0
    t.integer  "user_id",                                null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["user_id", "title"], name: "index_articles_on_user_id_and_title", unique: true, using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                  null: false
    t.string   "description",      limit: 512,             null: false
    t.integer  "commentable_id",                           null: false
    t.string   "commentable_type",                         null: false
    t.integer  "parent_id"
    t.integer  "like_times",                   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "user_name"
    t.string   "user_avatar"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  end

  create_table "honors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "contest_name",               null: false
    t.integer  "contest_level",              null: false
    t.string   "description"
    t.string   "team_name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "images",        limit: 1024
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "path"
    t.string   "filename",                             null: false
    t.string   "usage",                                null: false
    t.string   "description", limit: 2048
    t.integer  "auth",                     default: 0
    t.integer  "owner_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "submits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "pro_id",       limit: 128
    t.string   "run_id",       limit: 128
    t.integer  "run_time"
    t.integer  "memory"
    t.string   "lang",         limit: 64
    t.string   "result",       limit: 64
    t.text     "code",         limit: 65535
    t.datetime "submitted_at"
    t.integer  "status"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "oj_name",      limit: 32
    t.string   "origin_oj",    limit: 32
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_achievements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                      null: false
    t.integer  "achievement_id",               null: false
    t.integer  "current"
    t.integer  "total"
    t.boolean  "completed"
    t.datetime "completed_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "situation",      limit: 65535
    t.integer  "score"
    t.index ["user_id", "achievement_id"], name: "index_user_achievements_on_user_id_and_achievement_id", unique: true, using: :btree
  end

  create_table "user_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "stu_id"
    t.string   "phone"
    t.string   "school"
    t.string   "college"
    t.string   "major"
    t.string   "grade"
    t.string   "situation"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "train_rank"
    t.index ["user_id"], name: "index_user_infos_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",                                 null: false
    t.string   "display_name",                             null: false
    t.string   "password_digest", limit: 1024
    t.boolean  "gender"
    t.string   "avatar"
    t.integer  "role"
    t.integer  "status",                       default: 0
    t.string   "description",     limit: 1024
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["display_name"], name: "index_users_on_display_name", using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  end

end
