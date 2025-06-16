package dto;

import java.util.Date;

public class BrainTrainingResultsDto extends CustomeTemplateDto {
	
    // フィールド（引数）
	private int result_id;      //履歴ID
	private int user_id;        //利用者ID
	private int score;          //スコア
	private String game_type;   //ゲーム種類
	private Date played_at;     //実施日時
	
	public BrainTrainingResultsDto(int result_id, int user_id, int score, String game_type, Date played_at) {
		super();
		this.result_id = result_id;
		this.user_id = user_id;
		this.score = score;
		this.game_type = game_type;
		this.played_at = played_at;
	}

	public BrainTrainingResultsDto() {
		this(0,0,0,"",new Date());

	}

	public int getResult_id() {
		return result_id;
	}

	public void setResult_id(int result_id) {
		this.result_id = result_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getGame_type() {
		return game_type;
	}

	public void setGame_type(String game_type) {
		this.game_type = game_type;
	}

	public Date getPlayed_at() {
		return played_at;
	}

	public void setPlayed_at(Date played_at) {
		this.played_at = played_at;
	}
	
	
	
}
