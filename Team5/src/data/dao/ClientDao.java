package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import data.dto.ClientDto;
import oracle.db.DbConnect;

public class ClientDao {
	DbConnect db = new DbConnect();
	
	//�븘�씠�뵒濡� �씠由� �뼸�뼱�삤湲�
	public String getName(String id) {
		String name="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select name from client where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				name=rs.getString("name");
				return name;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return null; //X
	}
	//�쉶�썝媛��엯 Insert
	public int insertClient(ClientDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		//id,pass,name,hp,email,沅뚰븳(0)
		String sql="insert into client values (?,?,?,?,?,0)";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getHp());
			pstmt.setString(5, dto.getEmail());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; //db�삤瑜�
	}
	public int insertClient2(ClientDto dto,String reason) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into client2 values (seq_semi.nextval,?,?,?,sysdate,?)";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getName());
			pstmt.setString(3,dto.getHp());
			pstmt.setString(4,reason);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; //
	}

	
	//
	public int login(String id,String pass) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select pass from client where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("pass").equals(pass)) {
					return 1;//
				}else {
					return 0;//	
				}
			}
			return -1;//
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -2;//
	}
	
	public List<ClientDto> getAllClientList(int start,int end){
		List<ClientDto> list= new ArrayList<ClientDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql= "select a.* from (select client.*, rownum rnum from client)a where rnum>=? and rnum<=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ClientDto dto=new ClientDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setManager(rs.getString("manager"));				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public List<ClientDto> getSearchList(int start,int end,String search,String content){
		List<ClientDto> list= new ArrayList<ClientDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql= "select a.* from (select client.*, rownum r from client where "+search+" like ? order by id)a where r>=? and r<=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"%"+content+"%");
			pstmt.setInt(2,start);
			pstmt.setInt(3, end);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ClientDto dto=new ClientDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setManager(rs.getString("manager"));				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public int getCount(){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) from client";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;//error
	}
	
	public int getSearchCount(String search,String content){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) from client where "+search+" like ?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"%"+content+"%");
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;//error
	}
	//
	public ClientDto getClientData(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from client where id=?";
		ClientDto dto=new ClientDto();
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setManager(rs.getString("manager"));	
				
				return dto;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return null;//db�삤瑜� or �븘�씠�뵒 �뾾�쓬	
	}
	//�궘�젣
	public int deleteClient(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="delete from client where id=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;//
	}

	public int updateClient(ClientDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update client set hp=?,email=? where id=?";		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHp());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getId());
			
			return pstmt.executeUpdate(); 

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1; //�삤瑜�
	}
	
    public int updatePass(String id, String newpass) {
        Connection conn=null;
        PreparedStatement pstmt=null;
        String sql="update client set pass=? where id=?";      
        conn=db.getConnection();
        try {
           pstmt=conn.prepareStatement(sql);
           pstmt.setString(1, newpass);
           pstmt.setString(2, id);
           pstmt.execute();
           return 1; 
        } catch (SQLException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
        } finally {
           db.dbClose(pstmt, conn);
        }
        return -1; //
     }
	 
	 //관리자권한 확인
	 public int checkManage(String id) {
		int manage=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select manager from client where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				manage=Integer.parseInt(rs.getString("manager"));
				return manage;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return 2; //X
	}
	 public String findId(String name,String email) {
         Connection conn=null;
         PreparedStatement pstmt=null;
         ResultSet rs=null;
         String msg=null;
         String sql="select id from client where name=? and email=?";
         
         conn=db.getConnection();
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            rs=pstmt.executeQuery();
            if(rs.next()) {
               msg= name+"님의 아이디는 "+rs.getString("id")+"입니다";
               return msg;
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         return "입력하신 정보와 일치하는 아이디가 없습니다";//   
   }
    
    public String findPass(String id,String email) {
         Connection conn=null;
         PreparedStatement pstmt=null;
         ResultSet rs=null;
         String sql="select pass from client where id=? and email=?";
         
         conn=db.getConnection();
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, email);
            rs=pstmt.executeQuery();
            if(rs.next()) {
               return rs.getString("pass");
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         return "0";//
   }
    
    public int isEqualId(String id)
    {
       int find=0;
       Connection conn=null;
       PreparedStatement pstmt=null;
       ResultSet rs=null;
       String sql = "select count(*) from client where id=?";
      
       conn=db.getConnection();
       try {
          pstmt=conn.prepareStatement(sql);
          //諛붿씤�뵫
          pstmt.setString(1, id);
          //�떎�뻾
          rs=pstmt.executeQuery();
          //議곌굔
          if(rs.next()) {
             int n=rs.getInt(1);
             if(n==1)
                find=1;
          }
       } catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
       }finally {
          db.dbClose(rs, pstmt, conn);
       }
       return find;
    }
}
