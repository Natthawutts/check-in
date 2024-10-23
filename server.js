// const express = require('express');
// const { Pool } = require('pg');
// const path = require('path');

// const app = express();

// // ตั้งค่า EJS เป็น view engine
// app.set('view engine', 'ejs');
// app.set('views', path.join(__dirname, 'views'));

// // เสิร์ฟไฟล์ static
// app.use(express.static(path.join(__dirname, 'public')));

// // ตั้งค่าการเชื่อมต่อ PostgreSQL
// const pool = new Pool({
// user: 'postgres',
// host: 'localhost',
// database: 'studentcheck',
// password: 'rootroot',

// port: 5432,
// });


// app.get('/', (req, res) => {
//     res.render('check');  // เรนเดอร์ไฟล์ check.ejs
// });

// // เส้นทางหลัก
// app.get('/', async (req, res) => {
// try {
// const result = await pool.query('SELECT id, first_name, last_name, to_char(date_of_birth, \'YYYY-MM-DD\') AS date_of_birth ,sex ,status FROM student ORDER BY id');
// const student = result.rows;


// // ส่งข้อมูลไปยังหน้า index.ejs
// res.render('index', { student });
// } catch (err) {
// console.error(err);
// res.status(500).send('Server error');
// }
// });

// const PORT = process.env.PORT || 3000;
// app.listen(PORT, () => {
// console.log(`Server running on port ${PORT}`);
// });

const express = require('express');
const { Pool } = require('pg');
const path = require('path');

const app = express();

// ตั้งค่า EJS เป็น view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// เสิร์ฟไฟล์ static
app.use(express.static(path.join(__dirname, 'public')));

// ตั้งค่าการเชื่อมต่อ PostgreSQL
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'studentcheck',
    password: 'rootroot',
    port: 5432,
});

// เส้นทางหลัก ให้เริ่มต้นที่ check.ejs
app.get('/', (req, res) => {
    res.render('check');  // เรนเดอร์ไฟล์ check.ejs
});

// เส้นทางสำหรับหน้า index.ejs (สามารถเข้าถึงด้วย /students แทน)
app.get('/students', async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT s.id, p.prefix, s.first_name, s.last_name, 
                   to_char(s.date_of_birth, 'YYYY-MM-DD') AS date_of_birth,
                   s.sex, s.status
            FROM student s
            LEFT JOIN prefix p ON s.prefix_id = p.id
            ORDER BY s.id
        `);
        const student = result.rows;
        // console.log(student);
        // ดึงข้อมูลการเช็คชื่อจากตาราง attendance
        const attendanceResult = await pool.query('SELECT * FROM attendance');
        const attendance = attendanceResult.rows;

        // ส่งข้อมูลไปยังหน้า index.ejs
        res.render('index', { student, attendance, });
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

// เส้นทาง API สำหรับตรวจสอบรหัสนักศึกษา
app.get('/api/check-student/:studentID', async (req, res) => {
    const studentID = req.params.studentID;  // รับรหัสนักศึกษาจากพารามิเตอร์
    const activeDate = new Date(); // กำหนดเวลาเป็นปัจจุบัน
    try {
        // ค้นหารหัสนักศึกษาในฐานข้อมูล
        const result = await pool.query('SELECT * FROM student WHERE id = $1', [studentID]);

        // ตรวจสอบว่าพบรหัสนักศึกษาหรือไม่
        if (result.rows.length > 0) {
            const currentDateTime = new Date();


            // บันทึกการเช็คชื่อในตาราง attendance
            await pool.query(`
                INSERT INTO attendance (student_id, check_in_date, attendance_status) 
                VALUES ($1, NOW(), $2)`, 
                [studentID, 'มาเรียน']
            );
            res.json({ valid: true });
        } else {
            res.json({ valid: false });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ valid: false, message: 'Server error' });
    }
});

app.get('/personal/:studentID', async (req, res) => {
    const studentID = req.params.studentID;
    try {
        const result = await pool.query(`
            SELECT s.id, p.prefix, s.first_name, s.last_name, 
                   to_char(s.date_of_birth, 'YYYY-MM-DD') AS date_of_birth, 
                   s.sex, s.status, s.address, s.email, s.telephone, 
                   c.curr_name_th
            FROM student s
            LEFT JOIN prefix p ON s.prefix_id = p.id
            LEFT JOIN curriculum c ON s.curriculum_id = c.id  -- เชื่อมโยง curriculum
            WHERE s.id = $1`, 
            [studentID]);
        
        const student = result.rows[0]; 

        if (student) {
            res.render('personal', { student });
        } else {
            res.status(404).send('ไม่พบข้อมูลนักศึกษา');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('เกิดข้อผิดพลาดในการดึงข้อมูลนักศึกษา');
    }
});





const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
