#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#define WIDTH 640
#define HEIGHT 480
#define FRAME_RATE 30

//#define IMG_FILE "images.png"
#define IMG_FILE "lena.jpg"

int
main(int argc, char *argv[])
{
    cv::Mat src_img;
#if 1
    cv::VideoCapture cap(0);
    if (!cap.isOpened()) {
        std::cout << "video device is already opened!!" << std::endl;
        return -1;
    }

    cap >> src_img;
#else
    src_img = cv::imread(IMG_FILE, 1);
#endif
    if (src_img.empty()) {
        std::cout << "Error input image" << std::endl;
        return -1;
    }

    cv::Mat gray_img, bin_img;
    cv::cvtColor(src_img, gray_img, CV_BGR2GRAY);

    std::vector<std::vector<cv::Point> > contours;
    cv::threshold(gray_img, bin_img, 0, 255, cv::THRESH_BINARY|cv::THRESH_OTSU);
    cv::findContours(bin_img, contours, CV_RETR_LIST, CV_CHAIN_APPROX_NONE);

    int max_id = 0;
    double max_size = 0;
    for (int i = 0; i < contours.size(); ++i) {
        size_t count = contours[i].size();
        if (count < 150 || count > 500) {
            /* Exclude too small, too small countour */
            continue;
        }
        if (count <= max_size) {
            /* Use only the largest contour */
            continue;
        }
        cv::Mat pointsf;
        cv::Mat(contours[i]).convertTo(pointsf, CV_32F);
        cv::RotatedRect box = cv::fitEllipse(pointsf);
        cv::ellipse(src_img, box, cv::Scalar(0,0,255), 2, CV_AA);
        max_size = count;
        max_id = i;
    }

    cv::Moments mu = cv::moments(contours[max_id]);
    cv::Point2f mc = cv::Point2f(mu.m10/mu.m00 , mu.m01/mu.m00);
    cv::circle(src_img, mc, 4, cv::Scalar(100), 2, 4);
    std::cout << "center of gravity x:" << mc.x << " y:" << mc.y << std::endl;

    cv::namedWindow("fitEllipse", CV_WINDOW_AUTOSIZE|CV_WINDOW_FREERATIO);
    cv::imshow("fitEllipse", src_img);
    cv::waitKey(0);
}
