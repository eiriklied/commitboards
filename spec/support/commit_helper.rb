module CommitHelper
  def create_commit(board, user)
    Commit.create! board: board,
                   user: user,
                   sha: SecureRandom.hex,
                   project: 'my-project',
                   timestamp: Time.now.to_i,
                   image: File.new('spec/support/files/image.jpg')
  end
end
