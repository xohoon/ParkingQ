package kr.parkingq.service.admin;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.parkingq.domain.admin.AdminBoardVO;
import kr.parkingq.domain.admin.AdminMemberVO;
import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.admin.ChartVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.message.MessageVO;
import kr.parkingq.mapper.AdminMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private AdminMapper mapper;
	
	@Override
	public ArrayList<AdminMemberVO> getMember() {
		
		ArrayList<AdminMemberVO> list = new ArrayList<AdminMemberVO>();
		list = mapper.getMember();
		return list;
	}

	@Override
	public int updateAuth(AdminMemberVO member) {
		int resultNum = mapper.updateAuth(member);
		return resultNum;
	}

	@Override
	public String getAuth(String id) {
		String resultType = mapper.getAuth(id);
		return resultType;
	}

	@Override
	public int deleteUser(String id) {
		int resultNum = mapper.deleteUser(id);
		return resultNum;
	}

	@Override
	public AdminMemberVO getMemberInfo(String id) {
		return mapper.getMemberInfo(id);
	}

	@Override
	public int updateMember(AdminMemberVO adminMember) {
		return mapper.updateMember(adminMember);
	}

	@Override
	public int getWeekCountMember() {
		return mapper.getWeekCountMember();
	}

	@Override
	public ArrayList<MessageVO> getAllMessage() {
		return mapper.getAllMessage();
	}

	@Override
	public int getMessageTotalCount() {
		return mapper.getMessageTotalCount();
	}

	@Override
	public int deleteMessage(long no) {
		return mapper.deleteMessage(no);
	}

	@Override
	public ArrayList<AlarmVO> getAllBoard() {
		return mapper.getAllBoard();
	}

	@Override
	public int getBoardCount() {
		return mapper.getBoardCount();
	}

	@Override
	public AlarmVO getBoard(AlarmVO alarm) {
		AlarmVO content = mapper.getBoard(alarm);
		content.setType(alarm.getType());
		return content;
	}

	@Override
	public int updateBoard(AlarmVO alarm) {
		mapper.updateAdminBoard(alarm);
		return mapper.updateBoard(alarm);
	}

	@Override
	public int deleteBoard(AlarmVO alarm) {
		mapper.deleteAdminBoard(alarm);
		return mapper.deleteBoard(alarm);
	}

	@Override
	public ArrayList<AdminMemberVO> getLimitMember() {
		return mapper.getLimitMember();
	}

	@Override
	public ArrayList<MessageVO> getLimitMessage() {
		return mapper.getLimitMessage();
	}

	@Override
	public ArrayList<AlarmVO> getLimitAlarm() {
		return mapper.getLimitAlarm();
	}

	@Override
	public ArrayList<ChartVO> getMemberChart() {
		return mapper.getMemberChart();
	}

	@Override
	public ChartVO getBoardChart() {
		return mapper.getBoardChart();
	}

	@Override
	public ArrayList<AlarmVO> getMainLimitAlarm() {
		
		return mapper.getMainLimitAlarm();
	}

	@Override
	public String getCheckAdmin(String userId) {
		return mapper.getCheckAdmin(userId);
	}
	
	
	
	
	
}
