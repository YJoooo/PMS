package PMS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import PMS.dao.MainDao;
import PMS.vo.Account;
import PMS.vo.PrjParticipant;
import PMS.vo.SchPartiInfo;
import PMS.vo.SchParticipant;
import PMS.vo.Schedule;
import PMS.vo.ScheduleStatusCnt;

@Service
public class MainService {
	@Autowired(required=false)
	private MainDao dao;
	
	public String getTitleByNo(int pno) {
		return dao.getTitleByNo(pno);
	}
	public List<Schedule> getScheduleList(int pno) {
		return dao.getScheduleList(pno);
	}
	public Schedule getSchedule(int sno) {
		return dao.getSchedule(sno);
	}
	public void regSchedule(Schedule reg) {
		dao.regSchedule(reg);
	}
	public void uptSchedule(Schedule upt) {
		dao.uptSchedule(upt);
	}
	public void delSchedule(int sno) {
		dao.delSchedule(sno);
	}
	public void uptScheduleByPM(Schedule upt) {
		dao.uptScheduleByPM(upt);
	}
	public List<Account> getPrjparticipant(int pno){
		return dao.getPrjparticipant(pno);
	}
	// 프로젝트 진행도
	public int getProgress(int pno) {
		return dao.getProgress(pno);
	}
	// 일정 참가자 추가
	public void insSchParticipant(SchParticipant ins) {
		dao.insSchParticipant(ins);
	}
	// 일정 참가자 조회
	public List<SchPartiInfo> showSchPartiInfo(int sno){
		return dao.showSchPartiInfo(sno);
	}
	
	// 일정 진행상태별 비율 조회
	public List<ScheduleStatusCnt> getStatusCnt(int pno){
		return dao.getStatusCnt(pno);
	}
	
	// 일정 참가자 삭제
	public void delSchParticipant(SchParticipant del) {
		dao.delSchParticipant(del);
	}
	// 일정 참가자 삭제
	public void delSchPrjParticipant(PrjParticipant del) {
		dao.delSchPrjParticipant(del);
	}
	// 프로젝트 참가자 삭제
	public void delPrjParticipant(PrjParticipant del) {
		dao.delPrjParticipant(del);
	}

}
