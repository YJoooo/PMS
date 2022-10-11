package PMS.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import PMS.vo.Comment;
import PMS.vo.CommentFile;
import PMS.vo.Schedule;
import PMS.vo.Timeline;

@Repository
public interface commentDao {
	public List<Comment> commentList(int sno);
	public String getTitle(int sno);
	public String getSname(int sno);
	public String getWriter(String userno);
	public void insertComment(Comment ins);
	public Comment getDetail(int cno);
	public void updateComment(Comment upt);		
	public void deleteComment(int cno);
	public void insertFile(CommentFile file);
}
