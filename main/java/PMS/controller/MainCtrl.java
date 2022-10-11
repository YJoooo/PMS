package PMS.controller;

import java.time.LocalDate;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import PMS.service.AccountService;
import PMS.service.CalendarService;
import PMS.service.MainService;
import PMS.service.TimelineService;
import PMS.vo.Calendar;
import PMS.vo.PrjParticipant;
import PMS.vo.SchParticipant;
import PMS.vo.Schedule;
import PMS.vo.Timeline;

@Controller
public class MainCtrl {
    @Autowired(required=false)
    private MainService service;
    @Autowired(required = false)
	private CalendarService cservice;
    @Autowired(required=false)
    private AccountService serviceA;
    @Autowired(required=false)
    private TimelineService serviceT;
	// http://localhost:6080/PMS/loginPage.do
    
    // http://localhost:6080/PMS/goMain.do
    @RequestMapping("goMain.do")
    public String main(HttpServletRequest request, @RequestParam(value="pno", defaultValue="") int pno, Model d) {
		HttpSession session = request.getSession();
		session.setAttribute("pno", pno);
    	d.addAttribute("title", service.getTitleByNo(pno));
    	d.addAttribute("slist",service.getScheduleList(pno));
    	d.addAttribute("alist", serviceA.getAccountList());
    	d.addAttribute("prog", service.getProgress(pno));
    	d.addAttribute("tmlist",serviceT.getTimeline(pno));
    	d.addAttribute("schPlist", service.getPrjparticipant(pno));
    	return "WEB-INF\\views\\Main.jsp";
    }
    @RequestMapping("regScheduleModal.do")
	public String regScheduleModal(Schedule reg, Model d) {
		return "pageJsonReport";
	}
    @RequestMapping("regSchedule.do")
	public String regSchedule(HttpServletRequest request, Schedule reg,Timeline ins2, Model d) {
		HttpSession session = request.getSession();
    	int pno = 0;
		if(session!=null && session.getAttribute("pno")!=null) {
    		pno = (int)session.getAttribute("pno");
    	}
    	service.regSchedule(reg);
		serviceT.insertTimeline(ins2);
		ins2.setTmResult(ins2.getSname()+" 일정이 등록되었습니다.");
		serviceT.insResult(ins2);
		String start = reg.getStartDate_s();
		String end = reg.getEndDate_s();
		start = start+"T15:00:00.000Z";
		end = end+"T15:00:00.000Z";
		int sno = cservice.getRecentSno();
		Calendar ins = new Calendar(pno, sno, reg.getSname(), start, end, "", "#0099cc", "#ccffff", true);
		cservice.insertCalendar(ins);
		d.addAttribute("isReg","Y");
		return "WEB-INF\\views\\Main.jsp";
	}
    
    @RequestMapping("uptScheduleModal.do")
	public String uptScheduleModal(@RequestParam(value = "sno", defaultValue = "1") int sno, Model d) {
		d.addAttribute("schedule", service.getSchedule(sno));
		return "pageJsonReport";
	}
    @RequestMapping("uptSchedule.do")
	public String uptSchedule(Schedule upt, Model d) {
		service.uptSchedule(upt);
		d.addAttribute("pno", service.getSchedule(upt.getSno()).getPno());
		d.addAttribute("proc", "upt");
		return "WEB-INF\\views\\Main.jsp";
	}
	@RequestMapping("uptScheduleByPM.do")
	public String uptScheduleByPM(Schedule upt, Model d) {
		service.uptScheduleByPM(upt);
		d.addAttribute("proc", "upt");
		d.addAttribute("pno", service.getSchedule(upt.getSno()).getPno());
		String start = upt.getStartDate_s();
		String end = upt.getEndDate_s();
		start = start+"T15:00:00.000Z";
		end = end+"T15:00:00.000Z";
		Calendar uptCal = new Calendar(upt.getSno(), upt.getSname(), start, end);
		cservice.updateCalendar2(uptCal);
		return "WEB-INF\\views\\Main.jsp";
	}
	
    @RequestMapping("delSchedule.do")
	public String delSchedule(HttpServletRequest request, @RequestParam(value = "sno") int sno, Model d) {
    	HttpSession session = request.getSession();
    	int pno = 0;
    	if(session!=null && session.getAttribute("pno")!=null) {
    		pno = (int)session.getAttribute("pno");
    	}
    	service.delSchedule(sno);
    	// sno로 id값 찾기
    	try {
    		cservice.deleteCalendar(cservice.getIdBySno(sno));
    	}catch(Exception e){
    		e.getMessage();
    	}
    	d.addAttribute("proc", "del");
		d.addAttribute("pno", pno);
		return "WEB-INF\\views\\Main.jsp";
	}

	/*
	등록, 수정, 삭제할때 간트/풀캘린더 테이블 같이 dao로 CRUD하기
	 */
	//http://localhost:7080/PMS/getPrjparticipant.do?pno=2
	@RequestMapping("getPrjparticipant.do")
	public String getPrjparticipant(@RequestParam(value="pno", defaultValue="") int pno, Model d) {
		d.addAttribute("parlist",service.getPrjparticipant(pno));
		return "pageJsonReport";
	}
	
	// 일정 참가자 조회
	// http://localhost:8080/PMS/showSchPartiInfo.do
	@RequestMapping("showSchPartiInfo.do")
	public String showSchPartiInfo(@RequestParam("sno") int sno, Model d) {
		d.addAttribute("schParInfo", service.showSchPartiInfo(sno));
		return "pageJsonReport";
	}
	
	// 일정 참가자 추가
	@RequestMapping("insSchParticipant.do")
	public String insSchParticipant(SchParticipant ins, Model d) {
		service.insSchParticipant(ins);
		d.addAttribute("proc", "insParSch");
		d.addAttribute("presno", ins.getSno());
		return "WEB-INF/views/Main.jsp";
	}
	
	// 일정 참가자 삭제
	@RequestMapping("delSchParticipant.do")
	public String delSchParticipant(HttpServletRequest request, SchParticipant del, Model d) {
		HttpSession session = request.getSession();
    	int pno = 0;
    	if(session!=null&&session.getAttribute("pno")!=null) {
    		pno=(int)session.getAttribute("pno");
    	}
		service.delSchParticipant(del);
		d.addAttribute("proc", "delParSch");
		d.addAttribute("pno", pno);
		return "WEB-INF/views/Main.jsp";
	}
	
	// 프로젝트 참가자 삭제
	@RequestMapping("delPrjParticipant.do")
	public String delPrjParticipant(PrjParticipant del, Model d) {
		service.delSchPrjParticipant(del);
		service.delPrjParticipant(del);
		d.addAttribute("proc", "delParPrj");
		return "WEB-INF/views/Main.jsp";
	}
	
    @RequestMapping("getSchStatus.do")
    public String getStatusCnt(@RequestParam("pno") int pno,Model d) {
    	d.addAttribute("stRatio", service.getStatusCnt(pno));
    	return "pageJsonReport";
    }
}
