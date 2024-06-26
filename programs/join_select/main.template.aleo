import table2.aleo;
import table3.aleo;

program join_select.aleo;


struct Desc_table2:
    col_2_1 as field;
    col_2_2 as field;
    col_2_3 as boolean;


struct Desc_table3:
    col_3_1 as field;
    col_3_2 as field;


// Execting :
// SELECT t2.col_2_2 as col1, t3.col_3_1 as col2
// FROM aleo15epz3ejthprc70qyctnl5q4qtfjaparsfnwg7rm90v5gvtv2mvqq4n6kxj.table2 as t2
// JOIN aleo12z0zjgct2xys56z5k83n442fjtcyrnfjhnkvaldhp8e0qafssc9smytex2.table3 as t3
// ON t2.col_2_1 = t3.col_3_2

// If a field is not used, it is not included in the struct D000_njfgxxgjiqiceeavgt3djc6rv
// If it is used in SELECT projection, it is encrypted in the struct D000_njfgxxgjiqiceeavgt3djc6rv with receiver public key
// If it is used in JOIN ON, it is included in the struct D000_njfgxxgjiqiceeavgt3djc6rv as a s1.s2.m1.G (compared with s1.s2.m2.G)


struct Ciphertext:
    nonce as group;
    data as field;

struct On:
    in_pre_double_hash as group;
    ext_double_hash as group;

struct D0000_join_select:
    col_2_2 as Ciphertext;
    _on as On;

record R0000_join_select:
    owner as address.private;
    data as D0000_join_select.private;
    decoy as boolean.private;
    psk as scalar.private;


struct Desc_join_select:
    col1 as field;
    col2 as field;
    col3 as field;


record Row_join_select:
    owner as address.private;
    data as Desc_join_select.private;
    decoy as boolean.private;
    psk as scalar.private;


function p0000_join_select:
    input v_0000_0016 as table2.aleo/Row_table2.record; // row record
    input v_0000_0015 as scalar.private; // csk
    input v_0000_0014 as field.private; // previous state
    input v_0000_0013 as scalar.private; // previous csk
    input v_0000_0012 as field.public; // previous commit
    input v_0000_0011 as scalar.private; // out psk

    commit.bhp256 v_0000_0014 v_0000_0013 into v_0000_0010 as field;
    assert.eq v_0000_0012 v_0000_0010;

    hash.bhp256 v_0000_0016.data into v_0000_0009 as field;
    ternary v_0000_0016.decoy 0field v_0000_0009 into v_0000_0021;// To add
    add v_0000_0014 v_0000_0021 into v_0000_0008; // new state
    commit.bhp256 v_0000_0008 v_0000_0015 into v_0000_0007 as field; // new commit

    cast v_0000_0016.data.col_2_1 into v_0000_0006 as Desc_select; // SELECT close | v_0000_0006 is selected columns
    is.eq v_0000_0016.data.col_2_3 true into v_0000_0005; // WHERE close | v_0000_0005 is where condition
    
    not v_0000_0016.decoy into v_0000_0017; // Not decoy
    and v_0000_0017 v_0000_0005 into v_0000_0018; // Is result data relevant
    not v_0000_0018 into v_0000_0022;

    // Empty result creation if result data not relevant 
    ternary v_0000_0018 v_0000_0006.col 0field into v_0000_0020;
    // ... for each selected column

    cast v_0000_0020 into v_0000_0019 as Desc_select;
    cast aleo1l96m5aqndzqm6253xee2j887xxh4c6w6h9ksdaknst9mq3xrfv8senek7g v_0000_0019 v_0000_0022 v_0000_0011 into v_0000_0003 as R0000_join_select.record; // new row

    commit.bhp256 v_0000_0019 v_0000_0011 into v_0000_0002 as field; // output process commit
    // commit.bhp256 v_0000_0016.data v_0000_0016.psk into v_0000_0001 as field; // input process commit FOR

    output v_0000_0008 as field.private; // new state
    output v_0000_0007 as field.public; // new commit
    output v_0000_0003 as R0000_join_select.record; // encrypted result
    output v_0000_0002 as field.public; // output process commit
    // output v_0000_0001 as field.public; // input process commit


function process_select:
    input v_0000_0016 as table2.aleo/Row_table2.record; // row record
    input v_0000_0015 as scalar.private; // csk
    input v_0000_0014 as field.private; // previous state
    input v_0000_0013 as scalar.private; // previous csk
    input v_0000_0012 as field.public; // previous commit
    input v_0000_0011 as scalar.private; // out psk

    commit.bhp256 v_0000_0014 v_0000_0013 into v_0000_0010 as field;
    assert.eq v_0000_0012 v_0000_0010;

    hash.bhp256 v_0000_0016.data into v_0000_0009 as field;
    ternary v_0000_0016.decoy 0field v_0000_0009 into v_0000_0021;// To add
    add v_0000_0014 v_0000_0021 into v_0000_0008; // new state
    commit.bhp256 v_0000_0008 v_0000_0015 into v_0000_0007 as field; // new commit

    cast v_0000_0016.data.col_2_1 into v_0000_0006 as Desc_select; // SELECT close | v_0000_0006 is selected columns
    is.eq v_0000_0016.data.col_2_3 true into v_0000_0005; // WHERE close | v_0000_0005 is where condition
    
    not v_0000_0016.decoy into v_0000_0017; // Not decoy
    and v_0000_0017 v_0000_0005 into v_0000_0018; // Is result data relevant
    not v_0000_0018 into v_0000_0022;

    // Empty result creation if result data not relevant 
    ternary v_0000_0018 v_0000_0006.col 0field into v_0000_0020;
    // ... for each selected column

    cast v_0000_0020 into v_0000_0019 as Desc_select;
    cast aleo1l96m5aqndzqm6253xee2j887xxh4c6w6h9ksdaknst9mq3xrfv8senek7g v_0000_0019 v_0000_0022 v_0000_0011 into v_0000_0003 as Row_select.record; // new row

    commit.bhp256 v_0000_0019 v_0000_0011 into v_0000_0002 as field; // output process commit
    // commit.bhp256 v_0000_0016.data v_0000_0016.psk into v_0000_0001 as field; // input process commit FOR

    output v_0000_0008 as field.private; // new state
    output v_0000_0007 as field.public; // new commit
    output v_0000_0003 as Row_select.record; // encrypted result
    output v_0000_0002 as field.public; // output process commit
    // output v_0000_0001 as field.public; // input process commit

