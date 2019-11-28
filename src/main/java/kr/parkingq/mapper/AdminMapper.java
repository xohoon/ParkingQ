package kr.parkingq.mapper;

import java.util.ArrayList;

import kr.parkingq.domain.admin.AdminBoardVO;
import kr.parkingq.domain.admin.AdminMemberVO;
import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.admin.ChartVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.message.MessageVO;

public interface AdminMapper {

	public int adminDeleteBoard();

	public ArrayList<AdminMemberVO> getMember();

	public int updateAuth(AdminMemberVO member);

	public String getAuth(String id);

	public int deleteUser(String id);

	public AdminMemberVO getMemberInfo(String id);

	public int updateMember(AdminMemberVO adminMember);

	public int getWeekCountMember();

	public ArrayList<MessageVO> getAllMessage();

	public int getMessageTotalCount();

	public int deleteMessage(long no);

	public ArrayList<AlarmVO> getAllBoard();

	public int getBoardCount();

	public AlarmVO getBoard(AlarmVO alarm);

	public int updateBoard(AlarmVO alarm);

	public void updateAdminBoard(AlarmVO alarm);

	public void deleteAdminBoard(AlarmVO alarm);

	public int deleteBoard(AlarmVO alarm);

	public ArrayList<AdminMemberVO> getLimitMember();

	public ArrayList<AlarmVO> getLimitAlarm();

	public ArrayList<MessageVO> getLimitMessage();

	public ArrayList<ChartVO> getMemberChart();

	public ChartVO getBoardChart();

	public ArrayList<AlarmVO> getMainLimitAlarm();

	public String getCheckAdmin(String userId);

}
