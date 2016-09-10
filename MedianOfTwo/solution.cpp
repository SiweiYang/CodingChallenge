#include <vector>
using namespace std;

class Solution {
private:
    int next(vector<int>& nums1, int& t1, int &b1, vector<int>& nums2, int& t2, int& b2) {
        if (t1 == b1)return nums2[t2++];
        if (t2 == b2)return nums1[t1++];
        
        if (nums1[t1] <= nums2[t2])return nums1[t1++];
        return nums2[t2++];
    }
    
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        int m = nums1.size() + nums2.size();
        bool avg = m % 2 == 0;
        m = (m - 1)/2;
        
        int t1 = 0, t2 = 0;
        int b1 = nums1.size(), b2 = nums2.size();
        
        while (b1 - t1 > 5 && b2 - t2 > 5) {
            int p1 = (t1 + b1)/2, p2 = (t2 + b2)/2;
            if (nums1[p1] > nums2[p2]) {
                if (p1 - t1 + p2 - t2 >= m) {
                    b1 = p1 + 1;
                } else {
                    m -= p2 - 1 - t2;
                    t2 = p2 - 1;
                }
            } else {
                if (p1 - t1 + p2 - t2 >= m) {
                    b2 = p2 + 1;
                } else {
                    m -= p1 - 1 - t1;
                    t1 = p1 - 1;
                }
            }
        }
        
        if (b1 - t1 > m + 2)b1 = t1 + m + 2;
        if (b2 - t2 > m + 2)b2 = t2 + m + 2;
        
        if (b1 - t1 > 11) {
            m -= b1 - t1 - 11;
            t1 = b1 - 11;
        }
        
        if (b2 - t2 > 11) {
            m -= b2 - t2 - 11;
            t2 = b2 - 11;
        }
        
        while(m-- > 0)next(nums1, t1, b1, nums2, t2, b2);
        
        double sum = next(nums1, t1, b1, nums2, t2, b2);
        if (avg)sum = (sum + next(nums1, t1, b1, nums2, t2, b2))/2;
        
        return sum;
    }
};
