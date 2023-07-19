create or replace trigger trg_01
after insert
on employee
begin 
    dbms_output.put_line('신입사원이 입사했습니다.');
end;
/
insert into employee values (905,'길성춘','690512-1151432','gil_sj@kh.or.kr',
'01035464455','D5','J3','S5',3000000,0.1,200,sysdate,null,depault);

create table product(
    pcode number primary key,
    pname varchar2(30),
    brand varchar2(30),
    price number,
    stock number default 0
    );

CREATE TABLE PRO_DETAIL(
DCODE NUMBER PRIMARY KEY,
PCODE NUMBER,
PDATE DATE,
AMOUNT NUMBER,
STATUS VARCHAR2(10) CHECK (STATUS IN ('입고', '출고')),
FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE)
);

CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;
INSERT INTO PRODUCT 
VALUES(SEQ_PCODE.NEXTVAL, '갤럭스노트8', '삼송', 900000, DEFAULT);
INSERT INTO PRODUCT 
VALUES(SEQ_PCODE.NEXTVAL, '아이뽀8', '사과', 1000000, DEFAULT);
INSERT INTO PRODUCT 
VALUES(SEQ_PCODE.NEXTVAL, '대륙폰', '샤우미', 600000, DEFAULT);





create or  replace trigger tgr_02
after insert on pro_detail
for each row
    begin
        if :new.status='입고'
        then
            update product set stock = stock +:new.amount
            where pcode =:new.pcode;
        end if;
        
        if :new.status='출고'
        then
            update product set stock = stock +:new.amount
            where pcode =:new.pcode;
        end if;
    end;
    /
        insert into pro_detail values(seq_dcode.nextval,1,sysdate,5,'입고');
        insert into pro_detail values(seq_dcode.nextval,2,sysdate,10,'입고');
        insert into pro_detail values(seq_dcode.nextval,3,sysdate,20,'입고');
        insert into pro_detail values(seq_dcode.nextval,1,sysdate,1,'출고');
        insert into pro_detail values(seq_dcode.nextval,2,sysdate,7,'출고');
        insert into pro_detail values(seq_dcode.nextval,3,sysdate,11,'출고');