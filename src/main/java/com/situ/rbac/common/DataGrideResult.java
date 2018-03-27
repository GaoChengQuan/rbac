package com.situ.rbac.common;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * EasyUI DataGride 需要返回的数据格式
 * @param <T>
 */
public class DataGrideResult<T> implements Serializable {

	private Integer total;
	private List<T> rows;

	public DataGrideResult() {
		super();
	}

	public DataGrideResult(Integer total, List<T> rows) {
		super();
		this.total = total;
		this.rows = rows;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	@Override
	public String toString() {
		return "DataGrideResult [total=" + total + ", rows=" + rows + "]";
	}

}
